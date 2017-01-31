 DTA <- read.csv("hof_data.csv")

 ##create normalized variables in new columns
 DTA$R_Norm <- (DTA$R / DTA$AB)
 DTA$DB_Norm <- (DTA$DB / DTA$AB)
 DTA$TP_Norm <- (DTA$TP / DTA$AB)
 DTA$HR_Norm <- (DTA$HR / DTA$AB)
 DTA$RBI_Norm <- (DTA$RBI / DTA$AB)
 DTA$SB_Norm <- (DTA$SB / DTA$AB)
 DTA$CS_Norm <- (DTA$CS / DTA$AB)
 DTA$BB_Norm <- (DTA$BB / DTA$AB)
 DTA$SO_Norm <- (DTA$SO / DTA$AB)
 DTA$IBB_Norm <- (DTA$IBB / DTA$AB)
 DTA$HBP_Norm <- (DTA$HBP / DTA$AB)
 DTA$SH_Norm <- (DTA$SH / DTA$AB)
 DTA$SF_Norm <- (DTA$SF / DTA$AB)
 DTA$GIDP_Norm <- (DTA$GIDP / DTA$AB)
 DTA$DBTP_Norm <- (DTA$DBTP / DTA$AB)
 DTA$BBSB_Norm <- (DTA$BBSB / DTA$AB)

 Normalized <-c("SP", "ASG", "G", "AB", "R_Norm", "H_Norm", "DB_Norm", "TP_Norm", "HR_Norm", "RBI_Norm", "SB_Norm", "CS_Norm", "BB_Norm", "SO_Norm", "IBB_Norm", "HBP_Norm", "SH_Norm", "SF_Norm", "GIDP_Norm", "DBTP_Norm", "BBSB_Norm")
 DTA_Norm <- DTA[Normalized] ##error here
 cor(DTA_Norm)