{*
Testlink Open Source Project - http://testlink.sourceforge.net/

main page right side
 
@filesource	mainPageRight.tpl

@internal revisions
20110502 - franciscom - added grant check in order to display test execution header
20100825 - Julian - removed <p> tags from "test execution" and "test plan contents"
					blocks to eliminate unused space
					blocks are not draggable anymore
*}
{lang_get var="labels"
          s="current_test_plan,ok,testplan_role,msg_no_rights_for_tp,
             title_test_execution,href_execute_test,href_rep_and_metrics,
             href_update_tplan,href_newest_tcversions,
             href_my_testcase_assignments,href_platform_assign,
             href_tc_exec_assignment,href_plan_assign_urgency,
             href_upd_mod_tc,title_test_plan_mgmt,title_test_case_suite,
             href_plan_management,href_assign_user_roles,
             href_build_new,href_plan_mstones,href_plan_define_priority,
             href_metrics_dashboard,href_add_remove_test_cases"}


{$menuLayout=$tlCfg->gui->layoutMainPageRight}
{$display_right_block_1=false}
{$display_right_block_2=false}
{$display_right_block_3=false}

{if $gui->grants.testplan_planning == "yes" || $gui->grants.mgt_testplan_create == "yes" ||
	  $gui->grants.testplan_user_role_assignment == "yes" or $gui->grants.testplan_create_build == "yes"}
   {$display_right_block_1=true}

    <script  type="text/javascript">
    function display_right_block_1()
    {
        var rp1 = new Ext.Panel({
                                title: '{$labels.title_test_plan_mgmt}',
                                collapsible:false,
                                collapsed: false,
                                draggable: false,
                                contentEl: 'test_plan_mgmt_topics',
                                baseCls: 'x-tl-panel',
                                bodyStyle: "background:#c8dce8;padding:3px;",
                                renderTo: 'menu_right_block_{$menuLayout.testPlan}',
                                width:'100%'
                                });
     }
    </script>

{/if}

{if $gui->countPlans > 0 && $gui->grants.testplan_execute == "yes"}
   {$display_right_block_2=true}

    <script  type="text/javascript">
    function display_right_block_2()
    {
        var rp2 = new Ext.Panel({
                                 title: '{$labels.title_test_execution}',
                                 collapsible:false,
                                 collapsed: false,
                                 draggable: false,
                                 contentEl: 'test_execution_topics',
                                 baseCls: 'x-tl-panel',
                                 bodyStyle: "background:#c8dce8;padding:3px;",
                                 renderTo: 'menu_right_block_{$menuLayout.testExecution}',
                                 width:'100%'
                                });
     }
    </script>
{/if}

{if $gui->countPlans > 0 && $gui->grants.testplan_planning == "yes"}
   {$display_right_block_3=true}

    <script  type="text/javascript">
    function display_right_block_3()
    {
        var rp3 = new Ext.Panel({
                            title: '{$labels.title_test_case_suite}',
                            collapsible:false,
                            collapsed: false,
                            draggable: false,
                            contentEl: 'testplan_contents_topics',
                            baseCls: 'x-tl-panel',
                            bodyStyle: "background:#c8dce8;padding:3px;",
                            renderTo: 'menu_right_block_{$menuLayout.testPlanContents}',
                            width:'100%'
                                });
     }
    </script>

{/if}

{* ----- Right Column begin ---------------------------------------------------------- *}
<div class="vertical_menu" style="float: right; margin:10px 10px 10px 10px">
{* ----------------------------------------------------------------------------------- *}
	{if $gui->num_active_tplans > 0}
	  <div class="testproject_title">
     {lang_get s='help' var='common_prefix'}
     {lang_get s='test_plan' var="xx_alt"}
     {$text_hint="$common_prefix: $xx_alt"}
     {include file="inc_help.tpl" helptopic="hlp_testPlan" show_help_icon=true 
              inc_help_alt="$text_hint" inc_help_title="$text_hint"  
              inc_help_style="float: right;vertical-align: top;"}


 	   <form name="testplanForm" action="lib/general/mainPage.php">
 	   
 	   {* 
 	   IMPORTANT NOTICE: 
 	   because we are using this.form.submit, seems that URL arguments if added on
 	   form action ARE IGNORED. 
 	   *}
       <input type="hidden" name="tproject_id" value="{$gui->testprojectID}">	
       {if $gui->countPlans > 0}
		     {$labels.current_test_plan}:<br/>
		     <select style="z-index:1"  name="testplan" onchange="this.form.submit();">
		     	{section name=tPlan loop=$gui->arrPlans}
		     		<option value="{$gui->arrPlans[tPlan].id}"
		     		        {if $gui->arrPlans[tPlan].selected} selected="selected" {/if}
		     		        title="{$gui->arrPlans[tPlan].name|escape}">
		     		        {$gui->arrPlans[tPlan].name|truncate:#TESTPLAN_TRUNCATE_SIZE#|escape}
		     		</option>
		     	{/section}
		     </select>
		     
		     {if $gui->countPlans == 1}
		     	<input type="button" onclick="this.form.submit();" value="{$labels.ok}"/>
		     {/if}
		     
		     {if $gui->testplanRole neq null}
		     	<br />{$labels.testplan_role} {$gui->testplanRole|escape}
		     {/if}
	     {else}
         {if $gui->num_active_tplans > 0}{$labels.msg_no_rights_for_tp}{/if}
		   {/if}
	   </form>
	  </div>
  {/if}
	<br />

  <div id='menu_right_block_1'></div><br />
  <div id='menu_right_block_2'></div><br />
  <div id="menu_right_block_3"></div><br />
  
  {* ----------------------------------------------------------------------------------- *}
	{if $display_right_block_1}
    <div id='test_plan_mgmt_topics'>
    
      {if $gui->grants.mgt_testplan_create == "yes"}
	    	<img src="{$tlImages.bullet}" />
       		<a href="lib/plan/planView.php?tproject_id={$gui->testprojectID}">{$labels.href_plan_management}</a>
	    {/if}
	    
	    {if $gui->grants.testplan_create_build == "yes" and $gui->countPlans > 0}
	    	<br />
	    	<img src="{$tlImages.bullet}" />
           	<a href="lib/plan/buildView.php?tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_build_new}</a>
      {/if} {* testplan_create_build *}
	    
	    {if $gui->grants.testplan_user_role_assignment == "yes" && $gui->countPlans > 0}
	    	<br />
	    	<img src="{$tlImages.bullet}" />
       	    <a href="lib/usermanagement/usersAssign.php?featureType=testplan&amp;featureID={$gui->testplanID}">{$labels.href_assign_user_roles}</a>
	    {/if}
      
	    {if $gui->grants.testplan_planning == "yes" and $gui->countPlans > 0}
            <br />
        	<img src="{$tlImages.bullet}" />
           	<a href="lib/plan/planMilestonesView.php?tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_plan_mstones}</a>
	    {/if}
	    
    </div>
  {/if}
  {* ----------------------------------------------------------------------------------- *}

	{* ------------------------------------------------------------------------------------------ *}
	{if $display_right_block_2}
    <div id='test_execution_topics'>
		{if $gui->grants.testplan_execute == "yes"}
			<img src="{$tlImages.bullet}" />
			<a href="{$gui->launcher}?feature=executeTest&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_execute_test}</a>
			
			<br /> 
			<img src="{$tlImages.bullet}" />
			<a href="{$gui->url.testcase_assignments}?tproject_id={$gui->testprojectID}&tplan_id={$gui->testplanID}">{$labels.href_my_testcase_assignments}</a>
			<br />
		{/if} 
      
		{if $gui->grants.testplan_metrics == "yes"}
			<img src="{$tlImages.bullet}" />
			<a href="{$gui->launcher}?feature=showMetrics&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_rep_and_metrics}</a>
			
			<br />
			<img src="{$tlImages.bullet}" />
			<a href="{$gui->url.metrics_dashboard}?tproject_id={$gui->testprojectID}">{$labels.href_metrics_dashboard}</a>
		{/if} 
    </div>
	{/if}
  {* ------------------------------------------------------------------------------------------ *}

  {* ------------------------------------------------------------------------------------------ *}
	{if $display_right_block_3}
    <div id='testplan_contents_topics'>
		<img src="{$tlImages.bullet}" />
	    <a href="lib/platforms/platformsAssign.php?tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_platform_assign}</a>
		  <br />
		
		<img src="{$tlImages.bullet}" />
	    <a href="{$gui->launcher}?feature=planAddTC&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_add_remove_test_cases}</a>
	    <br />
		
		<img src="{$tlImages.bullet}" />
	   	<a href="{$gui->launcher}?feature=planUpdateTC&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_update_tplan}</a>
	    <br />

		<img src="{$tlImages.bullet}" />
	   	<a href="{$gui->launcher}?feature=newest_tcversions&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_newest_tcversions}</a>
	    <br />

		<img src="{$tlImages.bullet}" />
	   	<a href="{$gui->launcher}?feature=tc_exec_assignment&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_tc_exec_assignment}</a>
	    <br />

		{if $gui->tprojectOptions->testPriorityEnabled}
			<img src="{$tlImages.bullet}" />
	   		<a href="{$gui->launcher}?feature=test_urgency&tplan_id={$gui->testplanID}&tproject_id={$gui->testprojectID}">{$labels.href_plan_assign_urgency}</a>
		    <br />
		{/if}
    </div>
  {/if}
  {* ------------------------------------------------------------------------------------------ *}

</div>