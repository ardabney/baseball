 DTA <- read.csv("hof_data.csv")

 ##create normalized variables in new columns
 DTA <- transform(DTA, R_Norm = R/AB)
 DTA <- transform(DTA, DB_Norm = DB/AB)
 DTA <- transform(DTA, TP_Norm = TP/AB)
 DTA <- transform(DTA, HR_Norm = HR/AB)
 DTA <- transform(DTA, RBI_Norm = RBI/AB)
 DTA <- transform(DTA, SB_Norm = SB/AB)
 DTA <- transform(DTA, CS_Norm = CS/AB)
 DTA <- transform(DTA, BB_Norm = BB/AB)
 DTA <- transform(DTA, SO_Norm = SO/AB)
 DTA <- transform(DTA, IBB_Norm = IBB/AB)
 DTA <- transform(DTA, HBP_Norm = HBP/AB)
 DTA <- transform(DTA, SH_Norm = SH/AB)
 DTA <- transform(DTA, SF_Norm = SF/AB)
 DTA <- transform(DTA, GIDP_Norm = GIDP/AB)
 DTA <- transform(DTA, DBTP_Norm = DBTP/AB)
 DTA <- transform(DTA, BBSB_Norm = BBSB/AB)

 Normalized <-c("FY", "LY", "SP", "ASG", "G", "AB", "R_Norm", "H_Norm", "DB_Norm", "TP_Norm", "HR_Norm", "RBI_Norm", "SB_Norm", "CS_Norm", "BB_Norm", "SO_Norm", "IBB_Norm", "HBP_Norm", "SH_Norm", "SF_Norm", "GIDP_Norm", "DBTP_Norm", "BBSB_Norm")
 DTA_Norm <- DTA[Normalized]