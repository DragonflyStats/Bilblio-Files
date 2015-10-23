### install & load ggplot library
install.package("ggplot2")
library("ggplot2")
### show info about the data
head(diamonds)
head(mtcars)
### comparison qplot vs ggplot
# qplot histogram
qplot(clarity, data=diamonds, fill=cut, geom="bar")
# ggplot histogram -> same output
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
### how to use qplot
# scatterplot
qplot(wt, mpg, data=mtcars)
# transform input data with functions
qplot(log(wt), mpg - 10, data=mtcars)
# add aesthetic mapping (hint: how does mapping work)
qplot(wt, mpg, data=mtcars, color=qsec)
# change size of points (hint: color/colour, hint: set aesthetic/mapping)
qplot(wt, mpg, data=mtcars, color=qsec, size=3)
qplot(wt, mpg, data=mtcars, colour=qsec, size=I(3))
# use alpha blending
qplot(wt, mpg, data=mtcars, alpha=qsec)

-------------------------------------------- 3
clarity
count
0
2000
4000
6000
8000
10000
12000
I1 SI2 SI1 VS2 VS1 VVS2 VVS1 IF
cut
Fair
Good
Very Good
Premium
Ideal
qplot accepts transformed
input data
value
1
1
2
aesthetic
"green"
"red"
"blue"
aesthetics can be set
to a constant value
instead of mapping
values between 0 (transparent)
and 1 (opaque)
# continuous scale vs. discrete scale
head(mtcars)
qplot(wt, mpg, data=mtcars, colour=cyl)
levels(mtcars$cyl)
qplot(wt, mpg, data=mtcars, colour=factor(cyl))
# use different aesthetic mappings
qplot(wt, mpg, data=mtcars, shape=factor(cyl))
qplot(wt, mpg, data=mtcars, size=qsec)
# combine mappings (hint: hollow points, geom-concept, legend combination)
qplot(wt, mpg, data=mtcars, size=qsec, color=factor(carb))
qplot(wt, mpg, data=mtcars, size=qsec, color=factor(carb), shape=I(1))
qplot(wt, mpg, data=mtcars, size=qsec, shape=factor(cyl), geom="point")
qplot(wt, mpg, data=mtcars, size=factor(cyl), geom="point")
# bar-plot
qplot(factor(cyl), data=mtcars, geom="bar")
# flip plot by 90°
qplot(factor(cyl), data=mtcars, geom="bar") + coord_flip()
# difference between fill/color bars
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(cyl))
qplot(factor(cyl), data=mtcars, geom="bar", colour=factor(cyl))
# fill by variable
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))
# use different display of bars (stacked, dodged, identity)
head(diamonds)
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="stack")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="dodge")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="fill")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="identity")
qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="identity")
qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="stack")

-------------------------------------------- 4
wt
mpg 15
20
25
30
2 3 4 5
cyl
4
5
6
7
8
wt
mpg 15
20
25
30
2 3 4 5
factor(cyl)
4
6
8
wt
mpg 15
20
25
30
2 3 4 5
factor(cyl)
4
6
8
qsec
16
18
20
22
legends are combined if possible
flips the plot after calculation of
any summary statistics
factor(cyl)
count 0
2
4
6
8
10
12
14
4 6 8
factor(cyl)
4
6
8
factor(cyl)
count 0
2
4
6
8
10
12
14
4 6 8
factor(cyl)
4
6
8
clarity
count 0.0
0.2
0.4
0.6
0.8
1.0
I1 SI2 SI1 VS2 VS1VVS2VVS1 IF
cut
Fair
Good
Very Good
Premium
Ideal
clarity
count 1000
2000
3000
4000
5000
I1 SI2 SI1 VS2 VS1VVS2VVS1 IF
cut
Fair
Good
Very Good
Premium
Ideal
# using pre-calculated tables or weights (hint: usage of ddply in package plyr)
table(diamonds$cut)
t.table <- ddply(diamonds, c("clarity", "cut"), "nrow")
head(t.table)
qplot(cut, nrow, data=t.table, geom="bar")
qplot(cut, nrow, data=t.table, geom="bar", stat="identity")
qplot(cut, nrow, data=t.table, geom="bar", stat="identity", fill=clarity)
qplot(cut, data=diamonds, geom="bar", weight=carat)
qplot(cut, data=diamonds, geom="bar", weight=carat, ylab="carat")
### excursion ddply (split data.frame in subframes and apply functions)
ddply(diamonds, "cut", "nrow")
ddply(diamonds, c("cut", "clarity"), "nrow")
ddply(diamonds, "cut", mean)
ddply(diamonds, "cut", summarise, meanDepth = mean(depth))
ddply(diamonds, "cut", summarise, lower = quantile(depth, 0.25, na.rm=TRUE), median = median(depth, na.rm=TRUE),
upper = quantile(depth, 0.75, na.rm=TRUE))
t.function <- function(x,y){
z = sum(x) / sum(x+y)
return(z)
}
ddply(diamonds, "cut", summarise, custom = t.function(depth, price))
ddply(diamonds, "cut", summarise, custom = sum(depth) / sum(depth + price))
### back to ggplot
# histogram
qplot(carat, data=diamonds, geom="histogram")
# change binwidth
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)
# use geom to combine plots (hint: order of layers)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))
qplot(wt, mpg, data=mtcars, geom=c("smooth", "point"))
qplot(wt, mpg, data=mtcars, color=factor(cyl), geom=c("point", "smooth"))

-------------------------------------------- 5
cut
carat
0
2000
4000
6000
8000
10000
12000
14000
Fair Good Very Good Premium Ideal
carat
count
0
2000
4000
6000
8000
10000
1 2 3 4 5
carat
count
0
500
1000
1500
2000
2500
1 2 3 4 5
different binwidth changes the picture
wt
mpg 15
20
25
30
2 3 4 5
# tweeking the smooth plot ("loess"-method: polynomial surface using local fitting)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))
# removing standard error
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), se=FALSE)
# making line more or less wiggly (span: 0-1)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=0.6)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=1)
# using linear modelling
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm")
# using a custom formula for fitting
library(splines)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm", formula = y ~ ns(x,5))
# illustrate flip versus changing of variable allocation
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth"))
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth")) + coord_flip()
qplot(wt, mpg, data=mtcars, facets=cyl~., geom=c("point", "smooth"))
# save plot in variable (hint: data is saved in plot, changes in data do not change plot-data)
p.tmp <- qplot(factor(cyl), wt, data=mtcars, geom="boxplot")
p.tmp
# save mtcars in tmp-var
t.mtcars <- mtcars
# change mtcars
mtcars <- transform(mtcars, wt=wt^2)
# draw plot without/with update of plot data
p.tmp
p.tmp %+% mtcars
# reset mtcars
mtcars <- t.mtcars
rm(t.mtcars)
# get information about plot
summary(p.tmp)
# save plot (with data included)

-------------------------------------------- 6
flips the plot after calculation of
any summary statistics
wt
mpg 10
15
20
25
30
35
2 3 4 5
wt
mpg 10
15
20
25
30
2 3 4 5
wt
mpg 15
20
25
30
15
20
25
30
15
20
25
30
2 3 4 5
4 6 8
wt
mpg 10
15
20
25
30
10
15
20
25
30
10
15
20
25
30
2 3 4 5
4 6 8
mpg
wt 2
3
4
5
2
3
4
5
2
3
4
5
15 20 25 30
4 6 8
>	summary(p.tmp)
data:	mpg,	cyl,	disp,	hp,	drat,	wt,	qsec,	vs,	am,	
gear,	carb	[32x11]
mapping:		x	=	factor(cyl),	y	=	wt
faceting:	facet_grid(.	~	.,	FALSE)
-----------------------------------
geom_boxplot:		
stat_boxplot:		
position_dodge:	(width	=	NULL,	height	=	NULL)
save(p.tmp, file="temp.rData")
# save image of plot on disk (hint: svg device must be installed)
ggsave(file="test.pdf")
ggsave(file="test.jpeg", dpi=72)
ggsave(file="test.svg", plot=p.tmp, width=10, height=5)
### going further with ggplot
# create basic plot (hint: can not be displayed, no layers yet)
p.tmp <- ggplot(mtcars, aes(mpg, wt, colour=factor(cyl)))
p.tmp
# using additional layers (hint: ggplot draws in layers)
p.tmp + layer(geom="point")
p.tmp + layer(geom="point") + layer(geom="line")
# using shortcuts -> geom_XXX(mapping, data, ..., geom, position)
p.tmp + geom_point()
# using ggplot-syntax with qplot (hint: qplot creates layers automatically)
qplot(mpg, wt, data=mtcars, color=factor(cyl), geom="point") + geom_line()
qplot(mpg, wt, data=mtcars, color=factor(cyl), geom=c("point","line"))
# add an additional layer with different mapping
p.tmp + geom_point()
p.tmp + geom_point() + geom_point(aes(y=disp))
# setting aesthetics instead of mapping
p.tmp + geom_point(color="darkblue")
p.tmp + geom_point(aes(color="darkblue"))
# dealing with overplotting (hollow points, pixel points, alpha[0-1] )
t.df <- data.frame(x=rnorm(2000), y=rnorm(2000))
p.norm <- ggplot(t.df, aes(x,y))
p.norm + geom_point()
p.norm + geom_point(shape=1)
p.norm + geom_point(shape=".")
p.norm + geom_point(colour=alpha("black", 1/2))
p.norm + geom_point(colour=alpha("blue", 1/10))

-------------------------------------------- 7
mpg
wt 2
3
4
5
15 20 25 30
factor(cyl)
4
6
8
mpg
wt 100
200
300
400
15 20 25 30
factor(cyl)
4
6
8
x
y -3
-2
-1
0
1
2
3
-3 -2 -1 0 1 2 3
x
y -3
-2
-1
0
1
2
3
-3 -2 -1 0 1 2 3
x
y -3
-2
-1
0
1
2
3
-3 -2 -1 0 1 2 3
x
y -3
-2
-1
0
1
2
3
-3 -2 -1 0 1 2 3
# using facets (hint: bug in margins -> doesn't work)
qplot(mpg, wt, data=mtcars, facets=.~cyl, geom="point")
qplot(mpg, wt, data=mtcars, facets=gear~cyl, geom="point")
# facet_wrap / facet_grid
qplot(mpg, wt, data=mtcars, facets=~cyl, geom="point")
p.tmp <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
p.tmp + facet_wrap(~cyl)
p.tmp + facet_wrap(~cyl, ncol=3)
p.tmp + facet_grid(gear~cyl)
p.tmp + facet_wrap(~cyl+gear)
# controlling scales in facets (default: scales="fixed")
p.tmp + facet_wrap(~cyl, scales="free")
p.tmp + facet_wrap(~cyl, scales="free_x")
p.tmp + facet_wrap(~cyl, scales="fixed")
# contstraint on facet_grid (all rows,columns same scale)
p.tmp + facet_grid(gear~cyl, scales="free_x")
p.tmp + facet_grid(gear~cyl, scales="free", space="free")
# using scales (color palettes, manual colors, matching of colors to values)
p.tmp <- qplot(cut, data=diamonds, geom="bar", fill=cut)
p.tmp
p.tmp + scale_fill_brewer()
p.tmp + scale_fill_brewer(palette="Paired")
RColorBrewer::display.brewer.all()
p.tmp + scale_fill_manual(values=c("#7fc6bc","#083642","#b1df01","#cdef9c","#466b5d"))
p.tmp + scale_fill_manual("Color-Matching", c("Fair"="#78ac07", "Good"="#5b99d4",
"Ideal"="#ff9900", "Very Good"="#5d6778", "Premium"="#da0027", "Not used"="#452354"))
# changing text (directly in qplot / additional shortcut)
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point", xlab="Descr. of x-axis", ylab="Descr. of y-axis", main="Our
Sample Plot")
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + xlab("x-axis")
# changing name of legend (bug: in labs you must use "colour", "color" doesn't work)
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + labs(colour="Legend-Name")
# removing legend
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + scale_color_discrete(legend=FALSE)
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + opts(legend.position="none")

-------------------------------------------- 8
mpg
wt 2
3
4
5
2
3
4
5
2
3
4
5
4, 3
6, 3
8, 3
15 20 25 30
4, 4
6, 4
8, 5
15 20 25 30
4, 5
6, 5
15 20 25 30
mpg
wt 2
3
4
5
2
3
4
5
2
3
4
5
4
15 20 25 30
6
15 20 25 30
8
15 20 25 30
3 4 5
mpg
wt 2.0
2.5
3.0
3.5
4.0
4.5
5.0
4
22 24 26 28 30 32
8
12 14 16 18
2.8
3.0
3.2
3.4
6
18.0 18.5 19.0 19.5 20.0 20.5 21.0
mpg
wt 2.5
3.0
3.5
4.0
4.5
5.0
2.0
2.5
3.0
2.0
2.5
3.0
3.5
4
22 24 26 28 30 32
6
18.018.519.019.520.020.521.0
8
12 14 16 18
3 4 5
BrBG
PiYG
PRGn
PuOr
RdBu
RdGy
RdYlBu
RdYlGn
Spectral
Accent
Dark2
Paired
Pastel1
Pastel2
Set1
Set2
Set3
Blues
BuGn
BuPu
GnBu
Greens
Greys
Oranges OrRd
PuBu
PuBuGn
PuRd
Purples
RdPu
Reds
YlGn
YlGnBu
YlOrBr
YlOrRd
# moving legend to another place
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") + opts(legend.position="left")
# changing labels on legend
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") +
scale_colour_discrete(name="Legend for cyl", breaks=c("4","6","8"), labels=c("four", "six", "eight"))
# reordering breaks (values of legend)
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") +
scale_colour_discrete(name="Legend for cyl", breaks=c("8","4","6"))
# dropping factors
mtcars2 <- transform(mtcars, cyl=factor(cyl))
levels(mtcars2$cyl)
qplot(mpg, wt, data=mtcars2, colour=cyl, geom="point") + scale_colour_discrete(limits=c("4", "8"))
# limits vs zooming in vs breaks
p.tmp <- qplot(wt, mpg, data=mtcars, geom=c("point",
"smooth"), method="lm")
p.tmp
p.tmp + scale_x_continuous(limits=c(15,30))
p.tmp + coord_cartesian(xlim=c(15,30))
p.tmp
p.tmp + scale_x_continuous(breaks=c(15, 18, 27))
p.tmp + scale_x_continuous(breaks=c(15, 18, 27),
labels=c("low", "middle", "high"))
# using transformation
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point")
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") +
scale_y_continuous(trans="log2")
qplot(mpg, wt, data=mtcars, colour=factor(cyl), geom="point") +
scale_y_continuous(trans="log2") + scale_x_log10()
### themes
# use theme for plot only
qplot(mpg, wt, data=mtcars, geom="point")
qplot(mpg, wt, data=mtcars, geom="point") + theme_bw()
# change font-size for all labels (change base_size)
qplot(mpg, wt, data=mtcars, geom="point") + theme_bw(18)
# change theme for all future plots
theme_set(theme_bw())

-------------------------------------------- 9
mpg
wt 1
2
3
4
5
15 20 25 30
mpg
wt 2
3
4
5
16 18 20 22 24 26 28 30
mpg
wt 1
2
3
4
5
15 20 25 30
mpg
wt 1
2
3
4
5
15 18 27
mpg
wt 1
2
3
4
5
low middle high
# get current theme
theme_get()
# change specific options (hint: "color" does not work in theme_text() -> use colour)
qplot(mpg, wt, data=mtcars, geom="point", main="THIS IS A TEST-PLOT")
qplot(mpg, wt, data=mtcars, geom="point", main="THIS IS A TEST-PLOT") + opts(axis.line=theme_segment(),
plot.title=theme_text(size=20, face="bold", colour="steelblue"), panel.grid.minor=theme_blank(),
panel.background=theme_blank(), panel.grid.major=theme_line(linetype="dotted", colour="lightgrey", size=0.5),
panel.grid.major=theme_blank())
### create barplot like lattice
# use combination of geoms and specific stat for bin calculation
qplot(x=factor(gear), ymax=..count.., ymin=0, ymax=..count.., label=..count..,
data=mtcars, geom=c("pointrange", "text"), stat="bin", vjust=-0.5,
color=I("blue")) + coord_flip() + theme_bw()
### create a pie-chart, radar-chart (hint: not recommended)
# map a barchart to a polar coordinate system
p.tmp <- ggplot(mtcars, aes(x=factor(1), fill=factor(cyl))) + geom_bar(width=1)
p.tmp
p.tmp + coord_polar(theta="y")
p.tmp + coord_polar()
ggplot(mtcars, aes(factor(cyl), fill=factor(cyl))) + geom_bar(width=1) + coord_polar()

-------------------------------------------- 10
count
factor(gear) 3
4
5
15
12
5
0 2 4 6 8 10 12 14
factor(1)
count
1
0
5
10
15
20
25
30
factor(cyl)
4
6
8
factor(1)
count
0
5
10
15
20
25
30
factor(cyl)
4
6
8
factor(cyl)
count
0
2
4
6
8
10
12
14
4
6
8
factor(cyl)
4
6
8
### create survival/cumulative incidence plot
library(survival)
head(lung)
# create a kaplan-meier plot with survival package
t.Surv <- Surv(lung$time, lung$status)
t.survfit <- survfit(t.Surv~1, data=lung)
plot(t.survfit, mark.time=TRUE)
# define custom function to create a survival data.frame
createSurvivalFrame <- function(f.survfit){
# initialise frame variable
f.frame <- NULL
# check if more then one strata
if(length(names(f.survfit$strata)) == 0){
	 	 # create data.frame with data from survfit
f.frame <- data.frame(time=f.survfit$time, n.risk=f.survfit$n.risk, n.event=f.survfit$n.event, n.censor = f.survfit
$n.censor, surv=f.survfit$surv, upper=f.survfit$upper, lower=f.survfit$lower)
	 	 # create first two rows (start at 1)
f.start <- data.frame(time=c(0, f.frame$time[1]), n.risk=c(f.survfit$n, f.survfit$n), n.event=c(0,0),
n.censor=c(0,0), surv=c(1,1), upper=c(1,1), lower=c(1,1))
	 	 # add first row to dataset
	 	 f.frame <- rbind(f.start, f.frame)
	 	 # remove temporary data
	 	 rm(f.start)
}
else {
	 	 # create vector for strata identification
	 	 f.strata <- NULL
	 	 for(f.i in 1:length(f.survfit$strata)){
	 	 	 # add vector for one strata according to number of rows of strata
	 	 	 f.strata <- c(f.strata, rep(names(f.survfit$strata)[f.i], f.survfit$strata[f.i]))
	 	 }
	 	 # create data.frame with data from survfit (create column for strata)
f.frame <- data.frame(time=f.survfit$time, n.risk=f.survfit$n.risk, n.event=f.survfit$n.event, n.censor = f.survfit
$n.censor, surv=f.survfit$surv, upper=f.survfit$upper, lower=f.survfit$lower, strata=factor(f.strata))
	 	 # remove temporary data
	 	 rm(f.strata)
	 	 # create first two rows (start at 1) for each strata
	 	 for(f.i in 1:length(f.survfit$strata)){
	 	 	 # take only subset for this strata from data
	 	 	 f.subset <- subset(f.frame, strata==names(f.survfit$strata)[f.i])
	 	 	 # create first two rows (time: 0, time of first event)

-------------------------------------------- 11
f.start <- data.frame(time=c(0, f.subset$time[1]), n.risk=rep(f.survfit[f.i]$n, 2), n.event=c(0,0),
n.censor=c(0,0), surv=c(1,1), upper=c(1,1), lower=c(1,1), strata=rep(names(f.survfit$strata)[f.i],
2))
	 	 	 # add first two rows to dataset
	 	 	 f.frame <- rbind(f.start, f.frame)
	 	 	 # remove temporary data
	 	 	 rm(f.start, f.subset)
	 	 }
	 	 # reorder data
f.frame <- f.frame[order(f.frame$strata, f.frame$time), ]

 
 # rename row.names
	 	 rownames(f.frame) <- NULL
}
# return frame
return(f.frame)
}
# define custom function to draw kaplan-meier curve with ggplot
qplot_survival <- function(f.frame, f.CI="default", f.shape=3){
# use different plotting commands dependig whether or not strata's are given
if("strata" %in% names(f.frame) == FALSE){
	 	 # confidence intervals are drawn if not specified otherwise
	 	 if(f.CI=="default" | f.CI==TRUE ){
	 	 	 # create plot with 4 layers (first 3 layers only events, last layer only censored)
	 	 	 # hint: censoring data for multiple censoring events at timepoint are overplotted

 
 
 # (unlike in plot.survfit in survival package)
ggplot(data=f.frame) + geom_step(aes(x=time, y=surv), direction="hv") + geom_step(aes(x=time,
y=upper), directions="hv", linetype=2) + geom_step(aes(x=time,y=lower), direction="hv", linetype=2) +
geom_point(data=subset(f.frame, n.censor==1), aes(x=time, y=surv), shape=f.shape)
	 	 }
	 	 else {
	 	 	 # create plot without confidence intervalls
ggplot(data=f.frame) + geom_step(aes(x=time, y=surv), direction="hv") +
geom_point(data=subset(f.frame, n.censor==1), aes(x=time, y=surv), shape=f.shape)
	 	 }
}
else {
	 	 if(f.CI=="default" | f.CI==FALSE){
	 	 	 # without CI
ggplot(data=f.frame, aes(group=strata, colour=strata)) + geom_step(aes(x=time, y=surv),
direction="hv") + geom_point(data=subset(f.frame, n.censor==1), aes(x=time, y=surv), shape=f.shape)
	 	 }
	 	 else {
	 	 	 # with CI (hint: use alpha for CI)

-------------------------------------------- 12
ggplot(data=f.frame, aes(colour=strata, group=strata)) + geom_step(aes(x=time, y=surv),
direction="hv") + geom_step(aes(x=time, y=upper), directions="hv", linetype=2, alpha=0.5) +
geom_step(aes(x=time,y=lower), direction="hv", linetype=2, alpha=0.5) +
geom_point(data=subset(f.frame, n.censor==1), aes(x=time, y=surv), shape=f.shape)
	 	 }
}
}
# create frame from survival class (survfit)
t.survfit <- survfit(t.Surv~1, data=lung)
t.survframe <- createSurvivalFrame(t.survfit)
# create kaplan-meier-plot with ggplot
qplot_survival(t.survframe)
# drawing survival curves with several strata
t.Surv <- Surv(lung$time, lung$status)
t.survfit <- survfit(t.Surv~sex, data=lung)
plot(t.survfit)
# two strata
t.survframe <- createSurvivalFrame(t.survfit)
qplot_survival(t.survframe)
# with CI
qplot_survival(t.survframe, TRUE)
# add ggplot options, use different shape
qplot_survival(t.survframe, TRUE, 1) + theme_bw() + scale_colour_manual(value=c("green", "steelblue")) +
opts(legend.position="none")
# multiple strata
t.survfit <- survfit(t.Surv~ph.karno, data=lung)
t.survframe <- createSurvivalFrame(t.survfit)
qplot_survival(t.survframe)
# plot without confidence intervals and with different shape
qplot_survival(t.survframe, FALSE, 20)

-------------------------------------------- 13
time
surv 0.2
0.4
0.6
0.8
1.0
0 200 400 600 800 1000
overlay of qplot_survival and plot from
survival package
time
surv 0.2
0.4
0.6
0.8
1.0
0 200 400 600 800 1000
strata
sex=2
sex=1
time
surv 0.0
0.2
0.4
0.6
0.8
1.0
0 200 400 600 800 1000
strata
ph.karno=100
ph.karno=90
ph.karno=80
ph.karno=70
ph.karno=60
ph.karno=50
time
surv 0.2
0.4
0.6
0.8
1.0
0 200 400 600 800 1000
### multiple plots in one graphic
# define function to create multi-plot setup (nrow, ncol)
vp.setup <- function(x,y){
# create a new layout with grid
grid.newpage()
# define viewports and assign it to grid layout
pushViewport(viewport(layout = grid.layout(x,y)))
}
# define function to easily access layout (row, col)
vp.layout <- function(x,y){
viewport(layout.pos.row=x, layout.pos.col=y)
}
# define graphics
p.a <- qplot(mpg, wt, data=mtcars, geom="point") +
theme_bw()
p.b <- qplot(mpg, wt, data=mtcars, geom="bar",
stat="identity")
p.c <- qplot(mpg, wt, data=mtcars, geom="step")
# setup multi plot with grid
vp.setup(2,2)
# plot graphics into layout
print(p.a, vp=vp.layout(1, 1:2))
print(p.b, vp=vp.layout(2,1))
print(p.c, vp=vp.layout(2,2))

g
