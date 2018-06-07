安装：
    Maven是基于Java的工具，所以首要必须的要求是你的电脑上安装有JDK:
    设置 JAVA_HOME 环境变量指向你电脑中Java的安装根目录

    下载maven：
    
    设置环境变量：
        打开命令终端设置环境变量。
            export M2_HOME=/usr/local/apache-maven/apache-maven-2.2.1

            export M2=$M2_HOME/bin

            export MAVEN_OPTS=-Xms256m -Xmx512m

        添加Maven的bin目录到系统路径:
            export PATH=$M2:$PATH


Maven - POM:
        POM意为项目对象模型(Project Object Model)，是Maven中基本单元。
        它是一个名为pom.xml的XML文件，总是存在于项目的gen目录下。

        要注意的是每个项目需要有唯一的POM文件:
            所有的POM文件要求有projec节点和三个必须字段：
                    groupId, artifactId,version。
        在仓库中项目的标识为groupId:artifactId:version。
        POM.xml的根节点是project并且其下有三个主要的子节点：

                <groupId>com.companyname.projectgroup</groupId>
                <artifactId>project</artifactId>
                <version>1.0</version>


Maven - 构建生命周期:
        compile（编译）	编译	源代码编译在此阶段完成
            mvn compile
        package（打包）	打包	此阶段按照POM.xml的设置创建JAR或者WAR包

Maven - 构建配置文件:
    构建配置文件的类型:
        项目级（Per Project）	定义在项目的POM文件pom.xml中
        用户级 （Per User）	定义在Maven的设置xml文件中 (%USER_HOME%/.m2/settings.xml)
        全局（Global）	定义在Maven全局的设置xml文件中 (%M2_HOME%/conf/settings.xml)

    配置文件激活:
        使用命令控制台输入显式激活。
             <profiles>
                      <profile>
                      <id>test</id>
                  </profile>
            </profiles>
            mvn test -Ptest
            使用-P选项将配置文件的名字作为参数传入。

        通过maven设置。
            打开Maven的settings.xml文件，此文件可以在%USER_HOME%/.m2目录下获取
                    <activeProfiles>
                        <activeProfile>test</activeProfile>
                    </activeProfiles>
        基于环境变量（用户或者系统变量）。
            更新pom.xml里:
                <profile>
                   <id>test</id>
                   <activation>
                      <property>
                         <name>env</name>
                         <value>test</value>
                      </property>
                   </activation>
                </profile>
            创建一个环境变量“env”并且设置它的值为“test”。
        操作系统设置（比如说，Windows系列）。
        文件的存在或者缺失。
            <profile>
               <id>test</id>
               <activation>
                  <file>
                     <missing>target/generated-sources/axistools/wsdl2java/
                     com/companyname/group</missing>
                  </file>
               </activation>
            </profile>

Maven - 仓库:
        本地仓库（local）
            电脑上的某个目录地址。 它会在你第一次运行maven任意命令时创建
            Maven本地仓库保存着你项目所有的依赖（库的、插件的jar包等等）
            自动下载所有依赖的jar包到本地仓库中
            Maven默认在%USER_HOME%目录下创建Maven本地仓库
                Maven的setting.xml中指定另外一个路径:
                    <localRepository>C:/MyLocalRepository</localRepository>
        中央仓库（central）
            Maven 当未在本定仓库中找到任何的依赖时，Maven会使用下面的
                URL在中央仓库中搜索：http://repo1.maven.org/maven2/
            http://search.maven.org/#browse 供用户浏览Maven中央仓库的内容
            
        远程仓库（remote）
            开发者自己定制的包含库或者其他项目jar包的仓库。
            pom.xml:
               <repositories>
                <repository>
                     <id>companyname.lib1</id>
                     <url>http://download.companyname.org/maven2/lib1</url>
                </repository>
               </repositories>
                
Maven依赖搜索顺序:
        第1步 - 搜索本地仓库中的依赖，如果没有找到，进入第2步
        第2步 - 搜索中央仓库中的依赖，如果没有找到并且指定了远程仓库
        第3步 - 如果远程仓库没有指定，Maven将简单地停止构建并且抛出异常

Maven - 插件:
        Maven实际上是一个执行插件的框架，其所有的任务其实都是由插件完成
        作用：
            生成jar包文件
            生成war包文件
            编译源码文件
            代码单元测试
            生成项目文档
            生成j项目报告

        一个插件通常提供一系列的目标操:
            mvn [插件名]:[目标操作名]

    插件类型:
        构建插件（Build plugins）   <build\>节点中
        报告插件（Reporting plugins）  <reporting/>节点中。

        用的插件的列表：
            clean	构建完成后清理目标，删除目标目录。
            compiler	编译Java源文件。
            surefile	运行JUnit单元测试，生成测试报告。
            jar	从当前项目生成JAR文件。
            war	从当前项目生成WAR文件。
            javadoc	生成项目的Javadoc。
            antrun	运行任意指定构建阶段的一系列ant任务。


Maven - 创建项目:
    Maven使用 archetype 插件来创建项目
        mvn archetype:generate
            -DgroupId=com.companyname.bank 
            -DartifactId=consumerBanking 
            -DarchetypeArtifactId=maven-archetype-quickstart 
            -DinteractiveMode=fals

    Maven - 构建和测试项目:
        mvn clean package 
        首先是清理目标目录（clean），然后是将项目构建的输出打包成 jar 文件（package）。
        打包好的 jar 文件可在 consumerBanking\target 文件夹下获取
        测试报告可以在 consumerBanking\target\surefire-reports 文件夹下获取
        Maven 先编译源代码文件，然后是测试源代码文件。
        接着，Maven运行测试用例。
        最后Maven创建项目jar包。
        执行：
            java com.companyname.bank.App

    添加 Java 源文件：
        consumerBanking\src\main\java\com\companyname\bank
        添加类文件

Maven - 外部依赖:
        <dependency>
         <groupId>ldapjdk</groupId>
         <artifactId>ldapjdk</artifactId>
         <scope>system</scope>
         <version>1.0</version>
         <systemPath>${basedir}\src\lib\ldapjdk.jar</systemPath>
      </dependency>
            在src/lib/ldapjdk.jar放入这个文件

Maven - 项目文档:
        mvn site
            consumerBanking\target\site 文件

Maven - 项目模板:
        Maven 使用了Archetype的概念，提供给用户相当数量不同类型的项目模板


Maven - 管理依赖:
        依赖调解:   
            当遇到多个版本的 artifact 的时候，决定使用那个版本的依赖。如果两个版本的依赖在依赖树种处于同一深度时，第一个被声明的依赖将被使用。
        
            


        
