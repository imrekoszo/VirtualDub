## The "center cut" algorithm

Semi-recent versions of VirtualDub have an audio filter known as "center cut." This filter attempts to isolate the central components of the incoming signal and separate them from the side signals. The result is a stereo output with the ambience, and a mono output with the foreground sounds and vocals. To test this filter in VirtualDub, enable advanced audio filtering, then add input/center cut/output/discard filters to the filter graph, in that order (or swap discard and output).

Someone asked me by email if I could describe this algorithm, and I thought it would be blog-worthy.

Disclaimer: I'm not an audio researcher and am not familiar with the audio literature, so excuse me if I use the wrong terms or fail to acknowledge past work, as I am not familiar with existing advanced algorithms for vocal removal. I came up with this algorithm one day after a discussion about vector projection in lower-division math class, so I didn't do any research before devising the algorithm.

**The algorithm**

"Center cut" is a separation algorithm that works in frequency domain; it analyzes the phase of audio components of the same frequency on the left and right channels and attempts to determine the approximate center channel. The center channel is then subtracted from the original input to produce the side channels. Thus, one immediate limitation that should be apparent is that center cut requires stereo input. However, unlike the traditional method of vocal separation, taking the difference of left and right channels, the center cut algorithm is able to both produce _stereo_ ambience output and _extract_ the center channel.

The algorithm, as implemented in VirtualDub, is as follows:

*   Transform the left and right channels to frequency domain using the Fast Hartley Transform (FHT). I use a window size of 4096 and a raised cosine window.
*   For each frequency component, where L is the 2D vector from the left channel, and R is the 2D vector from the right channel:

*   Compute C = L/|L| + R/|R|.
*   Compute α such that (L-αC)∙(R-αC) = 0\. Basically, scale C so that when it is subtracted from L and R, the two resultant vectors are perpendicular. Expanding the math gives the equation (C∙C)a2 - C∙(L+R)α + (L∙R) = 0, which can be solved for α by the quadratic formula.
*   Compute C' = αC, L' = L-αC, and R' = R-αC.

*   Transform L', R', and C' back to time domain.
*   Overlap and add every quarter window (1024 samples).

Obviously, it isn't necessary to use a Fast Hartley Transform to do this; a Fast Fourier Transform (FFT) would do equally well as the results of a FHT and a real FFT can be easily exchanged. Also, the vector normalizations and the quadratic solve must be guarded against degenerate cases. As one or both source vectors shrink, the problem becomes increasingly ill-conditioned and the derived phase of the center vector becomes erratic; fortunately in this case the magnitude of the center vector also shrinks and the phase stability matters less. Finally, the components at DC and Nyquist rate only have a real component, so they are simply set to zero for the center channel.

The algorithm can be optimized to avoid explicit normalization, but care must be taken with regard to accuracy when doing so. In single-precision the alpha value from the quadratic solve already has marginal significand precision (~12 bits) and moving operations around can affect the output. IIRC, when I tried to do so, I got greater leakage from the center channel into the side channels. Double-precision would probably fare much better.

**Opportunities for improvement**

I'm sure a better overlap-and-add setup could be used.

The center cut algorithm whacks the phase of the left and right channels, so it has a tendency to move them apart in time and cause echoing effects in the side channels. This phenomenon becomes worse as the FHT window is increased, which is unfortunate as increasing the window size improves the quality of separation.

Overall imbalances in volume between the incoming left and right channels result in center leakage into the louder channel. It may be possible to add an adaptive normalizer into the algorithm to fix this.

<div class="entryfooter">7 comments | May 21, 2006 at 15:59 | default</div>

<div class="content" style="margin-top: 16px">

### Comments

**Comments posted:**

<a id="comm"></a>

* * *

This is interesting. I wanted something that did this several years ago to isolate some centre vocals from a stereo backing. At the time, the only thing I could do was remove the vocals and keep the backing by the usual inverting the phase of one channel.  
I must dig out those old recording and try this when I get time.

<small>**Baz** - 24 05 06 - 19:04</small>

* * *

Could this also be considered "Mid/Side" (M/S) coding, in contrast to the common Left/Right (L/R) coding?

<small>**Jens** - 25 05 06 - 20:49</small>

* * *

It's not the mid/side coding that is used in MPEG audio, if that's what you're thinking. Mid/side mode in MPEG simply encodes sum (L+R) and difference (L-R).  
In contrast, this method actually results in data expansion by 50%.

<small>**Phaeron** - 26 05 06 - 01:13</small>

* * *

I tried this and it works really well on some material, good job. The only problem is, when using a .wav file as source, there doesn't appear to be any way to save the processed result -- only test it with the test button.

<small>**Baz** - 27 05 06 - 13:02</small>

* * *

Yes, that was also my problem.  

I loaded a video file, and used the "Audio from other file" option. "Test" sounded right, but sound during playback was just the original, unprocessed sound. But when you choose to "Save wave" from the file menu, it will be the processed sound that is saved.  

I don't see the logic in this, but it works!  

By the way, I am absolutely crazy about how well this filter works for restoring old 78 rpm records. All 78's are mono, but I transfer them to digital with a stereo tip, the "Ortofon 78" that plugs right into my usual OM cartridge. Up till now, I have been unhappy that I got all that stereo noise. I could HEAR that there was a much "cleaner" centre in the sound picture, and that almost all the noise was in the extreme left and right.  

This plugin actually finds that "clean" sound that I could hear in the centre of the sound-scape!  

BUT: The sound seems to be even cleaner than what I could hear in the centre of the sound-picture before.  
So the plugin is probably not perfect.  
That's OK - I wouldn't expect a computer programme to be better at sound correction than the audio centre of the human brain...  

With regards,  

Maze

<small>**Maze** - 10 04 09 - 20:53</small>

* * *

WOOHOOOOO!  

=D

<small>**Camilo Martin** - 18 07 09 - 22:00</small>

* * *

This is a very very nice audio filter. I have tried many of these voice/vocal/'center band frequency' removers which produce mono/stereo output. Mono is completely out of the question for me and the ones that produced stereo output used FFT but introduced other noises/distortions to the side channels (sometimes in place of the center), this is far better than that. I think more effort by other programmers needs to be spent on developing this technique further.  

Many thanks,  
Jason

<small>**Jason** - 18 07 10 - 08:14</small>

</div>
