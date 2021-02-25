import time
import plotly.graph_objs as go
import numpy as np
import ipywidgets as ipw

def plot_complex_spectrum(data, N, fs, 
                          title='Complex Spectrum Plot', units='dBW', fc=0):
    plt_temp = (go.Scatter(x = np.arange(-fs/2, fs/2, fs/N) + fc,
                           y = data, name='Spectrum'))
    return go.FigureWidget(data = plt_temp,
                           layout = {'title': title, 
                                     'xaxis': {
                                         'title': 'Frequency (Hz)',
                                         'autorange': True},
                                     'yaxis': {
                                         'title': units}})
    
def freq_to_psd(data, N, fs):
    window=np.array(np.ones(N)[:])
    psd = (abs(data)**2)/(fs*np.sum(window**2))
    return 10*np.where(psd > 0, np.log10(psd), 0)

def plot_iq_timeseries(x, ax=None, **kwargs):
    if ax is None:
        ax = plt.gca()
    ax.plot(np.real(x), **kwargs)
    ax.plot(np.imag(x), **kwargs)
    ax.set_title('Time series plot')
    ax.set_xlabel('Samples')
    ax.set_ylabel('Magnitude')
    ax.legend(('Real', 'Imaginary'))
    return ax

def time_plot(number_samples, sample_frequency, c_data):
    figs = []

    plt_re_temp = (go.Scatter(x = np.arange(0, number_samples/sample_frequency, 1/sample_frequency), y = np.real(c_data), name='Real'))
    plt_im_temp = (go.Scatter(x = np.arange(0, number_samples/sample_frequency, 1/sample_frequency), y = np.imag(c_data), name='Imag'))
                                    
    figs.append(go.FigureWidget(data = [plt_re_temp, plt_im_temp],
            layout = {'title': ''.join(['Time Domain Plot of ADC Channel ', 
                                    str()]), 
            'xaxis': {'title' : 'Seconds (s)',
                                'autorange' : True},
            'yaxis' : {'title' : 'Amplitude (V)'}}))

    return ipw.VBox(figs)

def freq_plot(c_data, number_samples, sample_frequency):
    
    window   = np.ones(number_samples)
    w_data   = c_data * window
    fft_data = np.fft.fftshift(np.fft.fft(w_data))
    db_data  = freq_to_psd(fft_data, number_samples, fs=sample_frequency/2)

    return plot_complex_spectrum(
                data=db_data,
                N=number_samples,
                fs=sample_frequency/2,
                title=''.join(['Frequency Magnitude Plot of ADC Channel']),
                units='|Y(f)|',
                #fc=round(abs(rx_channel.adc_block.MixerSettings['Freq']))*1e6)
                fc = 0)