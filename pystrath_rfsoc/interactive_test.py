import plotly.graph_objs as go
import numpy as np
import ipywidgets as ipw
from pynq.overlays.base import BaseOverlay
import xrfdc

#base = BaseOverlay('base.bit')

#tx_channel = base.radio.transmitter.channel[0]
#rx_channel = base.radio.receiver.channel[0]

class mixer_functions():
        
        def configure_mixer_frequency(block, btype='adc', fc=1024):
            zone = block.NyquistZone
            even = True if ((zone % 2) == 0) else False
            req_zone = int(np.ceil(abs(fc)/((block.BlockStatus['SamplingFreq']*1e3)/2)))
            if req_zone != zone:
                block.NyquistZone = req_zone
            if even:
                true_fc = fc if btype=='adc' else -fc
            else:
                true_fc = -fc if btype=='adc' else fc
            block.MixerSettings['Freq'] = true_fc
            block.UpdateEvent(1)

class ComplexFrequencyPlot():

    def __init__(self,
                 configuration={}):

        default_config = {'sampling-freq' : 2048e6,
                          'number-samples' : 8192,
                          'centre-freq' : 0,
                          'height' : None,
                          'width' : None,
                          'title' : 'Complex Frequency Plot',
                          'x-axis-title' : 'Frequency (Hz)',
                          'y-axis-title' : 'Amplitude'}

        for default_key in default_config.keys():
            if default_key not in configuration:
                configuration[default_key] = default_config[default_key]

        self._config = configuration

        data = go.Scatter(
            x=np.arange(-self._config['sampling-freq']/2,
                        self._config['sampling-freq']/2,
                        self._config['sampling-freq']/self._config['number-samples'])
            + self._config['centre-freq'],
            y=np.zeros(8192))

        self._plot = go.FigureWidget(
            data=data,
            layout={'title' : self._config['title'],
                    'height': self._config['height'],
                    'width' : self._config['width'],
                    'xaxis' : {'title' : self._config['x-axis-title']},
                    'yaxis' : {'title' : self._config['y-axis-title']}})

    @property
    def configuration(self):
        return self._config

    @configuration.setter
    def configuration(self, configuration={}):
        for key in configuration.keys():
            if key not in self._config.keys():
                raise KeyError(''.join(['The key ', key, ' is not found in the class configuration.']))
            else:
                self._config.update({key : configuration[key]})
        self._update_plot()

    def _update_plot(self):
        self._plot.layout.height = self._config['height']
        self._plot.layout.width = self._config['width']
        self._plot.layout.xaxis.title = self._config['x-axis-title']
        self._plot.layout.yaxis.title = self._config['y-axis-title']
        self._plot.layout.title = self._config['title']
        self._plot.data[0].x = np.arange(-self._config['sampling-freq']/2,
                                         self._config['sampling-freq']/2,
                                         self._config['sampling-freq']/self._config['number-samples'])
        + self._config['centre-freq']

    def update_data(self, data):
        if len(data) != self._config['number-samples']:
            raise ValueError('Length of data must be the same as the plot.')
        else:
            self._plot.data[0].y = data

    def get_plot(self):
        return self._plot

class ComplexTimePlot():

    def __init__(self,
                 configuration={}):

        default_config = {'sampling-freq' : 2048e6,
                          'number-samples' : 8192,
                          'height' : None,
                          'width' : None,
                          'title' : 'Complex Time Plot',
                          'x-axis-title' : 'Time (s)',
                          'y-axis-title' : 'Amplitude'}

        for default_key in default_config.keys():
            if default_key not in configuration:
                configuration[default_key] = default_config[default_key]

        self._config = configuration

        data_re = go.Scatter(
            x=np.arange(0,
                        self._config['number-samples']/self._config['sampling-freq'],
                        1/self._config['sampling-freq']),
            y=np.zeros(8192),
            name='Real')

        data_im = go.Scatter(
            x=np.arange(0,
                        self._config['number-samples']/self._config['sampling-freq'],
                        1/self._config['sampling-freq']),
            y=np.zeros(8192),
            name='Imag')

        self._plot = go.FigureWidget(
            data=[data_re, data_im],
            layout={'title' : self._config['title'],
                    'height': self._config['height'],
                    'width' : self._config['width'],
                    'xaxis' : {'title' : self._config['x-axis-title']},
                    'yaxis' : {'title' : self._config['y-axis-title']}})
        
    @property
    def configuration(self):
        return self._config

    @configuration.setter
    def configuration(self, configuration={}):
        for key in configuration.keys():
            if key not in self._config.keys():
                raise KeyError(''.join(['The key ', key, ' is not found in the class configuration.']))
            else:
                self._config.update({key : configuration[key]})
        self._update_plot()

    def _update_plot(self):
        self._plot.layout.height = self._config['height']
        self._plot.layout.width = self._config['width']
        self._plot.layout.xaxis.title = self._config['x-axis-title']
        self._plot.layout.yaxis.title = self._config['y-axis-title']
        self._plot.layout.title = self._config['title']
        self._plot.data[0].x = np.arange(0,
                                         self._config['number-samples']/self._config['sampling-freq'],
                                         1/self._config['sampling-freq'])

    def update_data(self, data):
        if len(data) != self._config['number-samples']:
            raise ValueError('Length of data must be the same as the plot.')
        self._plot.data[0].y = data.real
        self._plot.data[1].y = data.imag

    def get_plot(self):
        return self._plot
    
class ToneGenerator():

    def __init__(self,
                 channel,
                 centre_frequency=0):
        
        self._channel = channel
        #To do DAC block check
        self.centre_frequency = centre_frequency
        
    @property
    def centre_frequency(self):
        return abs(self._channel.dac_block.MixerSettings['Freq'])
    
    @centre_frequency.setter
    def centre_frequency(self, centre_frequency):
        block = self._channel.dac_block
        if (centre_frequency > block.BlockStatus['SamplingFreq']*1e3) \
            or (centre_frequency < 0):
            raise ValueError ('Centre frequency out of range')
        zone = block.NyquistZone
        even = True if ((zone % 2) == 0) else False
        req_zone = int(np.ceil(abs(centre_frequency)/((block.BlockStatus['SamplingFreq']*1e3)/2)))
        if req_zone != zone:
            block.NyquistZone = req_zone
        if even:
            block.MixerSettings['Freq'] = -centre_frequency
        else:
            block.MixerSettings['Freq'] = centre_frequency


class FrequencyProcessor():

    def __init__(self,
                 configuration={}):

        default_config = {'sampling-freq' : 2048e6,
                          'window' : 'blackman'}

        for default_key in default_config.keys():
            if default_key not in configuration:
                configuration[default_key] = default_config[default_key]

        self._config = configuration

    def _window(self, data):
        return data * getattr(np, self._config['window'])(len(data))

    def _fft(self, data):
        return np.fft.fftshift(np.fft.fft(data))

    def _psd(self, data):
        return (abs(data)**2)/(self._config['sampling-freq']*np.sum(getattr(np, self._config['window'])(len(data))**2))

    def _decibel(self, data):
        return 10*np.where(data > 0, np.log10(data), 0)

    def convert_to_freq(self, data):
        data = self._window(data)
        data = self._fft(data)
        data = self._psd(data)
        return self._decibel(data)
    
class update_adc():
    
    def __init__(self,
                 configuration={}):
        
        default_config = {'desired-CoarseMixFreq' : xrfdc.COARSE_MIX_SAMPLE_FREQ_BY_FOUR}
        
        for default_key in default_config.keys():
            if default_key not in configuration:
                configuration[default_key] = default_config[default_key]

        self._config = configuration
        
        rx_channel.adc_block.MixerSettings.update({
                'CoarseMixFreq' : self.config['desired-CoarseMixFreq'],
                'MixerType': xrfdc.MIXER_TYPE_COARSE,
            })

    @property
    def configuration(self):
        return self._config

    @configuration.setter
    def configuration(self, configuration={}):
        for key in configuration.keys():
            if key not in self._config.keys():
                raise KeyError(''.join(['The key ', key, ' is not found in the class configuration.']))
            else:
                self._config.update({key : configuration[key]})
        self._update_generator()
        
    def _update_generator(self):
        
        rx_channel.adc_block.MixerSettings.update({
                'CoarseMixFreq' : self.config['desired-CoarseMixFreq'],
                'MixerType': xrfdc.MIXER_TYPE_COARSE,
            })
    

class ToneGeneratorApplication():

    def __init__(self,
                 sample_frequency=2048e6,
                 number_samples=2048,
                 centre_frequency=1024e6,
                 desired_frequency=0,
                 window='blackman',
                 height=None,
                 width=None):
        
        tx_channel.dac_block.MixerSettings.update({
                'MixerType': xrfdc.MIXER_TYPE_FINE,
                'FineMixerScale': xrfdc.MIXER_SCALE_0P7,
                'Freq': 0,
            })
        rx_channel.adc_block.MixerSettings.update({
                'CoarseMixFreq' : xrfdc.COARSE_MIX_SAMPLE_FREQ_BY_FOUR,
                'MixerType': xrfdc.MIXER_TYPE_COARSE,
            })
            
        def set_CoarseMixFreq(widget):
            desired_CoarseMixFreq = widget['new']
            self.update_adc.configuration = {'desired-CoarseMixFreq' : desired_CoarseMixFreq}

        def set_desired_freq(widget):
            desired_freq = widget['new']*1e6
            self.tone_generator.configuration = {
                'desired-freq' : desired_freq
            }
            signal = self.tone_generator.data
            #noise = np.random.normal(0, 0.001, number_samples) + np.random.normal(0, 0.001, number_samples)*1j
            #signal = time+noise
            self.time_plot.update_data(signal)
            freq = self.frequency_processor.convert_to_freq(signal)
            self.frequency_plot.update_data(freq)

        self.tone_generator = ToneGenerator(configuration={
            'sampling-freq'  : sample_frequency,
            'number-samples' : number_samples,
            'centre-freq'    : centre_frequency,
            'desired-freq'   : desired_frequency})

        self.frequency_processor = FrequencyProcessor(configuration={
            'sampling-freq'  : sample_frequency,
            'window'         : window})

        self.time_plot = ComplexTimePlot({
            'sampling-freq'  : sample_frequency,
            'number-samples' : number_samples,
            'height'         : height,
            'width'          : width,
            'title'          : 'Receiver: Complex Time Plot',
            'x-axis-title'   : 'Time (s)',
            'y-axis-title'   : 'Amplitude'})

        self.frequency_plot = ComplexFrequencyPlot({
            'sampling-freq'  : sample_frequency,
            'number-samples' : number_samples,
            'centre-freq'    : centre_frequency,
            'height'         : height,
            'width'          : width,
            'title'          : 'Receiver: Complex Frequency Plot',
            'x-axis-title'   : 'Frequency (Hz)',
            'y-axis-title'   : 'Power Spectral Density (dB)'})

        self.desired_freq_slider = ipw.FloatSlider(
            value=(desired_frequency)*1e-6,
            min=0,
            max=(sample_frequency)*1e-6,
            step=1,
            description='Transmitter Frequency:',
            disabled=False,
            continuous_update=True,
            orientation='horizontal',
            readout=True,
            style = {'description_width': 'initial'})
        
        self.desired_coarse_mix_freq_dropdown = ipw.Dropdown(
            options=[('fs/2', xrfdc.COARSE_MIX_SAMPLE_FREQ_BY_TWO), ('fs/4', xrfdc.COARSE_MIX_SAMPLE_FREQ_BY_FOUR), ('-fs/4', xrfdc.COARSE_MIX_MIN_SAMPLE_FREQ_BY_FOUR)],
            value=xrfdc.COARSE_MIX_SAMPLE_FREQ_BY_TWO,
            description='Mix Freq:',
            disabled=False,
            continuous_update=False,
            readout=True,
            )

        self.desired_freq_slider.observe(set_desired_freq, 'value')
        self.desired_coarse_mix_freq_dropdown(set_CoarseMixFreq, 'value')

    def display(self):
        return ipw.VBox([self.time_plot.get_plot(),
                         self.frequency_plot.get_plot(),
                         self.desired_freq_slider,
                         self.desired_coarse_mix_freq_dropdown])