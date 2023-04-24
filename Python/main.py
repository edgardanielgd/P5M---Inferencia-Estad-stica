"""
P5M - main.py

Statistic Inference
Python example for probabilistic distribution analysis
"""
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
from scipy.stats import norm, expon, chi2

def prob_distributions():

    """
    R Equivalences

    dnorm -> pdf() -> Probability density function
    pnorm -> cdf() -> Cumulative distribution function
    qnorm -> ppf() -> Percentile function
    pnorm (Lower tail) -> sf() -> Survival function
    qnorm (Lower tail) -> isf() -> Inverse Survival function
    rnorm -> rvs() -> Random sample
    """

    # Creating subplots in figure
    fig, axes = plt.subplots(3, 1)

    total_frames = 30
    # Animating subplots
    def animate(i): # i is the frame number, which goes from 1 to 30

        # Percentile plot for P( |X| > x) = P( X < -x ) + P( X > x )
        p = (1 / 2) * (i / total_frames)

        ### Normal distribution
        mu = 0
        sigma = 1

        min_domain = mu - 5
        max_domain = mu + 5

        x = np.linspace( min_domain, max_domain, 100)
        y = norm.pdf(x, mu, sigma)
        axes[0].clear()
        axes[0].plot(x, y, label="Normal Distribution")
        
        axes[0].set_ylabel("$f_X(x)$")
        axes[0].set_title("$Normal Distribution \\ Percentile P( |X| > x ) = %.2f $" % p)

        q1 = norm.ppf( p, mu, sigma) # Percentile calculation #1
        q2 = norm.ppf( 1 - p, mu, sigma) # Percentile calculation #2

        axes[0].axvline( q1, color="red")
        axes[0].axvline( q2, color="red")

        # Filtering areas to shade
        filter_min = [x <= (q1 if q1 >= min_domain else min_domain)]

        axes[0].fill_between(
            x[ tuple(filter_min)],
            y[ tuple(filter_min)],
            color="yellow"
        )

        filter_max = [ x >= (q2 if q2 <= max_domain else max_domain) ]
        axes[0].fill_between(
            x[ tuple(filter_max)],
            y[ tuple(filter_max)],
            color="yellow"
        )

        # Exponential distribution
        mu = 5

        min_domain = 0
        max_domain = mu + 10

        x = np.linspace( min_domain, max_domain, 100)
        y = expon.pdf(x, scale=1)
        axes[1].clear()
        axes[1].plot(x, y)

        axes[1].set_ylabel("$f_X(x)$")
        axes[1].set_title("$Exp Distribution \\ Percentile P( |X| > x ) = %.2f $" % (p / 5))

        q1 = expon.ppf( p / 5, mu ) # Percentile calculation #1
        q2 = expon.ppf( 1 - p / 5, mu ) # Percentile calculation #2

        axes[1].axvline( q1, color="red")
        axes[1].axvline( q2, color="red")

        # Filtering areas to shade
        filter_min = [x <= (q1 if q1 >= min_domain else min_domain)]

        axes[1].fill_between(
            x[ tuple(filter_min)],
            y[ tuple(filter_min)],
            color="yellow"
        )

        filter_max = [ x >= (q2 if q2 <= max_domain else max_domain) ]
        axes[1].fill_between(
            x[ tuple(filter_max)],
            y[ tuple(filter_max)],
            color="yellow"
        )
        
        # Chi 2 distribution
        df = 5 # Degrees of freedom (And this is also the mean value)

        min_domain = mu - 5
        max_domain = mu + 20

        x = np.linspace( min_domain, max_domain, 100)
        y = chi2.pdf(x, df)
        axes[2].clear()
        axes[2].plot(x, y)

        axes[2].set_xlabel("x")
        axes[2].set_ylabel("$f_X(x)$")
        axes[2].set_title("$Chi^2 Distribution Percentile P( |X| > x ) = %.2f $" % p)

        q1 = chi2.ppf( p, df) # Percentile calculation #1
        q2 = chi2.ppf( 1 - p, df) # Percentile calculation #2

        axes[2].axvline( q1, color="red", label="Percentile P( |X| > x )")
        axes[2].axvline( q2, color="red")

        # Filtering areas to shade
        filter_min = [x <= (q1 if q1 >= min_domain else min_domain)]

        axes[2].fill_between(
            x[ tuple(filter_min)],
            y[ tuple(filter_min)],
            color="yellow"
        )

        filter_max = [ x >= (q2 if q2 <= max_domain else max_domain) ]
        axes[2].fill_between(
            x[ tuple(filter_max)],
            y[ tuple(filter_max)],
            color="yellow"
        )

    # Animation
    ani = animation.FuncAnimation(
        fig,
        animate,
        frames=total_frames,
        interval=1000
    )

    # A little of margin at bottom
    plt.tight_layout()

    plt.show()

prob_distributions()

