<#include "../include/imports.ftl">

<@hst.setBundle basename="essentials.homepage"/>
<div>
  <h1><@fmt.message key="homepage.title" var="title"/>${title?html}</h1>
  <p><@fmt.message key="homepage.text" var="text"/>${text?html}</p>
  <#if !hstRequest.requestContext.cmsRequest>
    <p>
      <h3>Cluster Node Id: <#if clusterNodeId??>${clusterNodeId}</#if></h3>
    </p>
  </#if>
</div>
<div>
  <@hst.include ref="container"/>
</div>
