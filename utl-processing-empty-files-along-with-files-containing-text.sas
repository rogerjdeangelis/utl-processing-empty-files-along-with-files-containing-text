Processing empty files along with files containing text                                                           
                                                                                                                  
Not sure I full undersyand the ops issue, but this may help.                                                 
                                                                                                                  
Solution courtesy of Paul Dorfmans original post                                                                  
                                                                                                                  
GITHUB                                                                                                            
https://tinyurl.com/yylrl2k9                                                                                      
https://github.com/rogerjdeangelis/utl-processing-empty-files-along-with-files-containing-text                    
                                                                                                                  
SAS Forum                                                                                                         
https://tinyurl.com/y49cac8e                                                                                      
https://communities.sas.com/t5/SAS-Programming/Infile-properties-of-empty-file/m-p/585216                         
                                                                                                                  
*_                   _                                                                                            
(_)_ __  _ __  _   _| |_                                                                                          
| | '_ \| '_ \| | | | __|                                                                                         
| | | | | |_) | |_| | |_                                                                                          
|_|_| |_| .__/ \__,_|\__|                                                                                         
        |_|                                                                                                       
;                                                                                                                 
                                                                                                                  
* Meta data containing a list of files;                                                                           
data meta;                                                                                                        
  input fyl $14.;                                                                                                 
cards4;                                                                                                           
d:/txt/one.txt                                                                                                    
d:/txt/two.txt                                                                                                    
d:/txt/tre.txt                                                                                                    
;;;;                                                                                                              
run;quit;                                                                                                         
                                                                                                                  
* create files;                                                                                                   
data _null_;                                                                                                      
                                                                                                                  
 file "d:/txt/one.txt";                                                                                           
   put "Same data for 1";                                                                                         
                                                                                                                  
 file "d:/txt/two.txt";                                                                                           
 /* empty */                                                                                                      
                                                                                                                  
 file "d:/txt/tre.txt";                                                                                           
   put "Same data for 3";                                                                                         
                                                                                                                  
run;quit;                                                                                                         
                                                                                                                  
WORK.META total obs=3                                                                                             
                                                                                                                  
       FYL                                                                                                        
                                                                                                                  
  d:/txt/one.txt                                                                                                  
  d:/txt/two.txt                                                                                                  
  d:/txt/tre.txt                                                                                                  
                                                                                                                  
                                                                                                                  
Contents of files                                                                                                 
                                                                                                                  
 d:/txt/one.txt                                                                                                   
                                                                                                                  
     Some data for 1                                                                                              
                                                                                                                  
 d:/txt/two.txt                                                                                                   
    /* empty */                                                                                                   
                                                                                                                  
 d:/txt/tre.txt";                                                                                                 
                                                                                                                  
    Some data for 3                                                                                               
                                                                                                                  
                                                                                                                  
*            _               _                                                                                    
  ___  _   _| |_ _ __  _   _| |_                                                                                  
 / _ \| | | | __| '_ \| | | | __|                                                                                 
| (_) | |_| | |_| |_) | |_| | |_                                                                                  
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                 
                |_|                                                                                               
;                                                                                                                 
                                                                                                                  
                                                                                                                  
WANT total obs=3                                                                                                  
                                                                                                                  
   META_FILE            TXT            STATUS                                                                     
                                                                                                                  
 d:/txt/one.txt    Same data for    file has data                                                                 
 d:/txt/two.txt                     file is empty                                                                 
 d:/txt/tre.txt    Same data for    file has data                                                                 
                                                                                                                  
 *                                                                                                                
 _ __  _ __ ___   ___ ___  ___ ___                                                                                
| '_ \| '__/ _ \ / __/ _ \/ __/ __|                                                                               
| |_) | | | (_) | (_|  __/\__ \__ \                                                                               
| .__/|_|  \___/ \___\___||___/___/                                                                               
|_|                                                                                                               
;                                                                                                                 
                                                                                                                  
                                                                                                                  
data _null_;                                                                                                      
                                                                                                                  
 file "d:/txt/one.txt";                                                                                           
 put "Same data for 1";                                                                                           
                                                                                                                  
 file "d:/txt/two.txt";                                                                                           
 /* empty */                                                                                                      
 file "d:/txt/tre.txt";                                                                                           
 put "Same data for 3";                                                                                           
                                                                                                                  
run;quit;                                                                                                         
                                                                                                                  
data meta;                                                                                                        
  input fyl $14.;                                                                                                 
cards4;                                                                                                           
d:/txt/one.txt                                                                                                    
d:/txt/two.txt                                                                                                    
d:/txt/tre.txt                                                                                                    
;;;;                                                                                                              
run;quit;                                                                                                         
                                                                                                                  
data want ;                                                                                                       
  length meta_file txt $14;                                                                                       
  set meta;                                                                                                       
  infile dummy filevar=fyl end=empty;                                                                             
  meta_file=fyl;                                                                                                  
  if empty then do;                                                                                               
     status="file is empty";                                                                                      
     txt="";                                                                                                      
  end;                                                                                                            
  else do;                                                                                                        
     input txt $14.;                                                                                              
     status="file has data";                                                                                      
  end;                                                                                                            
run;quit;                                                                                                         
                                                                                                                  
                                                                                                                  
