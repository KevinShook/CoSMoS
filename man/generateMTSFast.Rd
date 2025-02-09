% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generateMTSFast.r
\name{generateMTSFast}
\alias{generateMTSFast}
\title{Faster simulation of multiple time series with approximately separable spatiotemporal correlation structure}
\usage{
generateMTSFast(
  n,
  spacepoints,
  margdist,
  margarg,
  p0,
  distbounds = c(-Inf, Inf),
  stcsid,
  stcsarg,
  scalefactor = 1,
  anisotropyarg = list(phi1 = 1, phi2 = 1, theta = 0)
)
}
\arguments{
\item{n}{number of fields (time steps) to simulate}

\item{spacepoints}{matrix (d x 2) of coordinates (e.g. longitude and latitude) of d spatial locations (e.g. d gauge stations)}

\item{margdist}{target marginal distribution of the field}

\item{margarg}{list of marginal distribution arguments}

\item{p0}{probability zero}

\item{distbounds}{distribution bounds (default set to c(-Inf, Inf))}

\item{stcsid}{spatiotemporal correlation structure ID}

\item{stcsarg}{list of spatiotemporal correlation structure arguments}

\item{scalefactor}{factor specifying the distance between the centers of two pixels (default set to 1)}

\item{anisotropyarg}{list of arguments establishing spatial anisotropy. phi1 and phi2 control the stretch in two orthogonal directions (e.g., longitude and latitude) while the angle theta controls a counterclockwise rotation (default set to list(phi1 = 1, phi2 = 1 , theta = 0) for isotropic fields)}
}
\description{
For more details see section 6 in \href{https://doi.org/10.1029/2018WR023055}{Serinaldi and Kilsby (2018)}, and section 2.4 in \href{https://doi.org/10.1029/2019WR026331}{Papalexiou and Serinaldi (2020)}
}
\details{
\code{\link{generateMTSFast}} provides a faster approach to multivariate simulation
compared to \code{\link{generateMTS}} by exploiting circulant embedding
fast Fourier transformation.
However, this approach is feasible only for approximately
separable target spatiotemporal correlation functions (see section 6 in
\href{https://doi.org/10.1029/2018WR023055}{Serinaldi and Kilsby (2018)}).
\code{\link{generateMTSFast}} comprises fitting and simulation in a single function.
Here, we give indicative CPU times for some settings, referring to a
Windows 10 Pro x64 laptop with Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz,
4-core, 8 logical processors, and 32GB RAM. \cr
CPU time:\cr
d = 2500, n = 1000: ~58s \cr
d = 2500, n = 10000: ~160s \cr
d = 10000, n = 1000: ~2955s (~50min) \cr
}
\examples{
coord <- cbind(runif(4)*30, runif(4)*30)

sim <- generateMTSFast(
    n = 50,
    spacepoints = coord,
    p0 = 0.7,
    margdist ='paretoII',
    margarg = list(scale = 1,
                   shape = .3),
    stcsarg = list(scfid = "weibull",
                   tcfid = "weibull",
                   scfarg = list(scale = 20,
                                 shape = 0.7),
                   tcfarg = list(scale = 1.1,
                                 shape = 0.8))
)


}
