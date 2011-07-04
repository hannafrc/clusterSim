\name{speccl}
\alias{speccl}
\title{A spectral clustering algorithm}
\description{A spectral clustering algorithm. Cluster analysis is performed by embedding the data into the subspace of the eigenvectors of an affinity matrix}
\usage{
speccl(data,nc,distance="GDM1",sigma="automatic",mod.sample=0.75,
R=10,iterations=3,na.action=na.omit,...)
}
\arguments{
\item{data}{matrix or dataset}
\item{nc}{the number of clusters}
\item{distance}{distance function used to calculate affinity matrix: e.g. "sEuclidean" - squared Euclidean distance, "GDM1" - GDM distance for metric data, "GDM2" - GDM distance for ordinal data, 
"SM" - Sokal-Michener distance measure for nominal variables, "BC" - Bray-Curtis distance measure for ratio data or other distances included in functions dist, dist.GDM and dist.binary}
\item{sigma}{scale parameter used to calculate affinity matrix: "automatic" - an algorithm for searching optimal value of sigma parameter; "manual" - value of sigma parameter given by researcher}
\item{mod.sample}{proportion of data to use when estimating sigma (default: 0.75)}
\item{R}{the number of intervals examined in each step of searching optimal value of sigma parameter algorithm 

(See \$R\_HOME\\library\\clusterSim\\pdf\\speccl\_details.pdf)}
\item{iterations}{the maximum number of iterations (rounds) allowed in algorithm of searching optimal value of sigma parameter}
\item{na.action}{the action to perform on NA}
\item{...}{arguments passed to kmeans procedure}

}
\details{
See file \$R\_HOME\\library\\clusterSim\\pdf\\speccl\_details.pdf for further details
}
\value{
\item{clustering}{a vector of integers indicating the cluster to which each object is allocated} 
\item{size}{the number of objects in each cluster}
\item{withinss}{the within-cluster sum of distances for each cluster}
\item{Ematrix}{data matrix n x p (n - the number of objects, u - the number of eigenvectors)}
\item{Ymatrix}{normalized data matrix n x p (n - the number of objects, u - the number of eigenvectors)}
\item{sigma}{The value of scale parameter given by searching algorithm}
}
\author{
Marek Walesiak \email{marek.walesiak@ue.wroc.pl}, Andrzej Dudek \email{andrzej.dudek@ue.wroc.pl} 

Department of Econometrics and Computer Science, University of Economics, Wroclaw, Poland \url{http://keii.ue.wroc.pl/clusterSim}
}
\references{

Karatzoglou, A. (2006), \emph{Kernel methods. Software, algorithms and applications}, Dissertation, Wien, Technical University.

Ng, A., Jordan, M., Weiss, Y. (2002), \emph{On spectral clustering: analysis and an algorithm}, In: T. Dietterich, S. Becker, Z. Ghahramani (Eds.), Advances in Neural Information Processing Systems 14. MIT Press, 849-856.

Walesiak, M. (2006), \emph{Uogolniona miara odleglosci w statystycznej analizie wielowymiarowej [The Generalized Distance Measure in multivariate statistical analysis]}, Wydawnictwo AE, Wroclaw.

Walesiak, M. (2011), \emph{Klasyfikacja spektralna a skale pomiaru zmiennych [Spectral clustering and measurement scales of variables]}, Prace Naukowe UE we Wroclawiu (in preparation).
}

\seealso{
\code{\link{dist.GDM}},\code{specc},\code{\link{kmeans}},\code{\link{dist}},\code{\link{dist.binary}},\code{\link{dist.SM}},\code{\link{dist.BC}}
}
\examples{
# Example 1
library(clusterSim)
library(mlbench)
data<-mlbench.spirals(100,1,0.03)
plot(data)
x<-data$x
res1<-speccl(x,nc=2,distance="GDM1",sigma="automatic",
mod.sample=0.75,R=10,iterations=3)
clas1<-res1$cluster
print(data$classes)
print(clas1)
cRand<-classAgreement(table(as.numeric(as.vector(data$classes)),
res1$cluster))$crand
print(cRand)

# Example 2
library(clusterSim)
grnd2<-cluster.Gen(50,model=4,dataType="m",numNoisyVar=1)
data<-as.matrix(grnd2$data)
colornames<-c("red","blue","green")
grnd2$clusters[grnd2$clusters==0]<-length(colornames)
plot(grnd2$data,col=colornames[grnd2$clusters])
res2<-speccl(data,nc=3,distance="sEuclidean",sigma="automatic",
mod.sample=0.75,R=10,iterations=3)
cRand<-comparing.Partitions(grnd2$clusters,res2$cluster,type="crand")
print(cRand)

# Example 3
library(clusterSim)
grnd3<-cluster.Gen(40,model=4,dataType="o",numCategories=7)
data<-as.matrix(grnd3$data)
plotCategorial(grnd3$data,pairsofVar=NULL,cl=grnd3$clusters,
clColors=c("red","blue","green"))
res3<-speccl(data,nc=3,distance="GDM2",sigma="automatic",
mod.sample=0.75,R=10,iterations=3)
cRand<-comparing.Partitions(grnd3$clusters,res3$cluster,type="crand")
print(cRand)

# Example 4
library(clusterSim)
data(data_nominal)
res4<-speccl(data_nominal,nc=4,distance="SM",sigma="automatic",
mod.sample=0.75,R=10,iterations=3)
print(res4)

# Example 5
library(clusterSim)
data(data_binary)
res5<-speccl(data_binary,nc=3,distance=1,sigma="automatic",
mod.sample=0.75,R=10,iterations=3)
print(res5)

}
\keyword{spectral clustering, cluster analysis}