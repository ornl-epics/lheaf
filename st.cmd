#!../../bin/linux-x86_64/idec

## You may have to change idec to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/idec.dbd"
idec_registerRecordDeviceDriver pdbbase


# Define protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(IDEC)/protocol")

epicsEnvSet("IP_ADDR1","10.112.63.50:2103")
epicsEnvSet("IP_ADDR2","10.112.63.51:2103")

#AMI1800
asynSetAutoConnectTimeout(1.0)
drvAsynIPPortConfigure ("COM1","$(IP_ADDR1)",0,0,0)
drvAsynIPPortConfigure ("COM2","IP_ADDR2",0,0,0)


#This prints low level commands and responses

asynSetTraceMask("COM2",0,0x07)
asynSetTraceIOMask("COM2",0,0x07)


dbLoadRecords("db/idec.db")



cd "${TOP}/iocBoot/${IOC}"
iocInit

epicsThreadSleep(5)



dbpf SE:SE:IDEC:COMMUNICATION “$(IP_ADDR1)”
dbpf SE2:SE2:IDEC2:COMMUNICATION “$(IP_ADDR2)”



asynSetTraceMask("COM1",0,0x07)
asynSetTraceIOMask("COM1",0,0x07)


