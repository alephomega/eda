config <- function() { 
  list (
    fs = "hdfs://on-hadoop-master1.daum.net:8020",
    jt = "on-hadoop-master1.daum.net:8021",
    jar = list (
      mr = "analytics.jar",
      rmr = "rmr.jar"
    ),
    
    job = list (
      base_dir = "/user/hdfs/analytics",
      tasks = list (
        pdist = list (
          main = "com.valuepotion.analytics.eda.PurchaseDistribution",
          properties = list (
            mapred.max.split.size = 67108864,
            mapred.child.java.opts = "-Xmx1024m",
            io.file.buffer.size = 65536,
            io.sort.mb = 512
          ),

          overwrite = TRUE
        )
      )
    )
  )
}

