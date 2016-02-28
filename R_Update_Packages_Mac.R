#http://www.r-bloggers.com/update-all-user-installed-r-packages-again/
#Find out the path
.libPaths()[1]
lib<-"/Library/Frameworks/R.framework/Versions/3.1/Resources/library"

## Get currently installed packages
package_df <- as.data.frame(installed.packages(lib))

package_list <- as.character(package_df$Package)

## Re-install Install packages
install.packages(package_list)

#Don't restart R as some packaes are loaded
#A lot of self created packages/ or htmlwidget packages are not available on CRAN etc. 
#Need to keep track of these

sessionInfo()