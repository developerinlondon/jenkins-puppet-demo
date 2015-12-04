include ::apt
include jenkins

jenkins::plugin {
  'ansicolor' :
    version => '0.3.1';
  'jquery' :
  	version => '1.11.2-0';
  'parameterized-trigger' :
  	version => '2.29';
  'build-pipeline-plugin' :
   	version => '1.4.9';
  'git': 
  	version => "2.4.0";
  'build-flow-plugin':
  	version => '0.18';
}

jenkins::job {
  'Build' :
    config => '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties></properties>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>echo “Building application”
/vagrant/git-code/build.sh
</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>';
  'Run Tests':
    config => '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties></properties>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>echo "Running Tests"
/vagrant/git-code/run_test.sh
</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>';
  'Deploy':
    config => '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties></properties>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>echo "Deploying"
/vagrant/git-code/deploy.sh
exit 0
</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>';
  'Everything':
    config => '<?xml version=\'1.0\' encoding=\'UTF-8\'?>
<com.cloudbees.plugins.flow.BuildFlow plugin="build-flow-plugin@0.18">
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers/>
  <icon/>
  <dsl>build( &quot;Build&quot; )
build( &quot;Run Tests&quot; )
build( &quot;Deploy&quot; )</dsl>
  <buildNeedsWorkspace>false</buildNeedsWorkspace>
</com.cloudbees.plugins.flow.BuildFlow>';
}

# file { '/var/lib/jenkins':
#   ensure  => file,
#   content => '<?xml version='1.0' encoding='UTF-8'?>
# <hudson>
#   <disabledAdministrativeMonitors/>
#   <version>1.0</version>
#   <numExecutors>2</numExecutors>
#   <mode>NORMAL</mode>
#   <useSecurity>true</useSecurity>
#   <authorizationStrategy class="hudson.security.AuthorizationStrategy$Unsecured"/>
#   <securityRealm class="hudson.security.SecurityRealm$None"/>
#   <disableRememberMe>false</disableRememberMe>
#   <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
#   <workspaceDir>${ITEM_ROOTDIR}/workspace</workspaceDir>
#   <buildsDir>${ITEM_ROOTDIR}/builds</buildsDir>
#   <jdks/>
#   <viewsTabBar class="hudson.views.DefaultViewsTabBar"/>
#   <myViewsTabBar class="hudson.views.DefaultMyViewsTabBar"/>
#   <clouds/>
#   <scmCheckoutRetryCount>0</scmCheckoutRetryCount>
#   <views>
#     <hudson.model.AllView>
#       <owner class="hudson" reference="../../.."/>
#       <name>All</name>
#       <filterExecutors>false</filterExecutors>
#       <filterQueue>false</filterQueue>
#       <properties class="hudson.model.View$PropertyList"/>
#     </hudson.model.AllView>
#     <au.com.centrumsystems.hudson.plugin.buildpipeline.BuildPipelineView plugin="build-pipeline-plugin@1.4.9">
#       <owner class="hudson" reference="../../.."/>
#       <name>Build Pipeline</name>
#       <filterExecutors>false</filterExecutors>
#       <filterQueue>false</filterQueue>
#       <properties class="hudson.model.View$PropertyList"/>
#       <gridBuilder class="au.com.centrumsystems.hudson.plugin.buildpipeline.DownstreamProjectGridBuilder">
#         <firstJob>Build</firstJob>
#       </gridBuilder>
#       <noOfDisplayedBuilds>1</noOfDisplayedBuilds>
#       <buildViewTitle></buildViewTitle>
#       <consoleOutputLinkStyle>Lightbox</consoleOutputLinkStyle>
#       <cssUrl></cssUrl>
#       <triggerOnlyLatestJob>false</triggerOnlyLatestJob>
#       <alwaysAllowManualTrigger>false</alwaysAllowManualTrigger>
#       <showPipelineParameters>false</showPipelineParameters>
#       <showPipelineParametersInHeaders>false</showPipelineParametersInHeaders>
#       <startsWithParameters>false</startsWithParameters>
#       <refreshFrequency>3</refreshFrequency>
#       <showPipelineDefinitionHeader>false</showPipelineDefinitionHeader>
#     </au.com.centrumsystems.hudson.plugin.buildpipeline.BuildPipelineView>
#   </views>
#   <primaryView>All</primaryView>
#   <slaveAgentPort>0</slaveAgentPort>
#   <label></label>
#   <nodeProperties/>
#   <globalNodeProperties/>
# </hudson>',
# }