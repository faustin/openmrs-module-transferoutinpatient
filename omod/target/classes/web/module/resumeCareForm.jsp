<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/moduleResources/tracpatienttransfer/scripts/jquery-1.3.2.js" />
<openmrs:htmlInclude file="/moduleResources/tracpatienttransfer/patienttransfers.css" />

<openmrs:require privilege="Resume care" otherwise="/login.htm" redirect="" />

<script type="text/javascript">
	var $j = jQuery.noConflict();
</script>

<h2><spring:message code="tracpatienttransfer.resumeCare" /></h2>

<br/>
<b class="boxHeader"><spring:message code="tracpatienttransfer.resumeCare"/> <c:if test="${lastObs ne null}">: ${lastObs.valueCoded.name} <spring:message code="tracpatienttransfer.general.on"/> <openmrs:formatDate date="${lastObs.obsDatetime}" type="medium"/></c:if></b>
<div class="box" id="formTransfer">
	<form method="post" action="resumeCare.form?patientId=${param.patientId}&save=true" name="resumeCareForm">
	
		<div id="errorDivNewId" style="margin-bottom: 5px;"></div>
	
		<table>
			<tr>
				<td width="250px"><input id="prtSave" value="${param.save}" type="hidden"/></td>
				<td></td>
				<td><input name="patientId" value="${patient.patientId}" type="hidden"/></td>
				<td></td>
			</tr>
			<tr>
		   		<td><spring:message code="Patient.names"/></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.patientNames"/>"/></td>
		       	<td><b>${patient.personName}</b></td>
				<td></td>
		  	</tr>
			<tr>
		   		<td><spring:message code="tracpatienttransfer.resumeCare.reason"/></td>
				<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.help.resumeCare.reason"/>"/></td>
		       	<td><select name="resumeCareReason" id="resumeCareReasonId">
		       			<option value="<spring:message code="tracpatienttransfer.reason.resumeCare.error"/>"><spring:message code="tracpatienttransfer.reason.resumeCare.error"/></option>
		       			<c:if test="${lastObs.valueCoded.conceptId eq patientTransferredOutConceptId}">
		       				<option value="<spring:message code="tracpatienttransfer.reason.resumeCare.shiftingplace"/>"><spring:message code="tracpatienttransfer.reason.resumeCare.shiftingplace"/></option>
		       			</c:if>
		       			<c:if test="${lastObs.valueCoded.conceptId eq patientDefaultedConceptId}">
		       				<option selected="selected" value="<spring:message code="tracpatienttransfer.reason.resumeCare.defaulted.return"/>"><spring:message code="tracpatienttransfer.reason.resumeCare.defaulted.return"/></option>
		       			</c:if>
		       			<c:if test="${lastObs.valueCoded.conceptId eq patientRefusedConceptId}">
		       				<option selected="selected" value="<spring:message code="tracpatienttransfer.reason.resumeCare.refused.rejoin"/>"><spring:message code="tracpatienttransfer.reason.resumeCare.refused.rejoin"/></option>
		       			</c:if>
		       		</select>
		       	</td>
				<td><span id="resumeCareReasonError"></span></td>
		  	</tr> 
		  	<c:if test="${relatedEncounter ne null}">		
				<tr>
					<td></td>
			   		<td colspan="3"><div id="voidEncounterDivId" style="<c:if test="${lastObs.valueCoded.conceptId eq patientDefaultedConceptId || lastObs.valueCoded.conceptId eq patientRefusedConceptId}">display:none;</c:if>"><input type="checkbox" name="voidEncounter" id="voidEncounterId" checked="checked" disabled="disabled"/>
			   			<label for="voidEncounterId"><spring:message code="tracpatienttransfer.resumeCare.void.encounter"/>(<b>@${relatedEncounter.location} on <openmrs:formatDate date="${relatedEncounter.encounterDatetime}" type="medium"/></b>)</label>
			   				<br/>
			   				<input type="checkbox" name="unDiscontinueOrder" id="unDiscontinueOrderId" checked="checked" disabled="disabled"/>
			   			<label for="unDiscontinueOrderId"><spring:message code="tracpatienttransfer.resumeCare.unDiscontinueOrder"/></label>
			   			<br/>
			   				<input type="checkbox" name="unCompleteProgram" id="unCompleteProgramId" checked="checked" disabled="disabled"/>
			   			<label for="unCompleteProgramId"><spring:message code="tracpatienttransfer.resumeCare.unCompleteProgram"/></label>
			   			</div></td>
			  	</tr>
			</c:if> 
		  	<c:if test="${lastObs.valueCoded.conceptId eq patientDefaultedConceptId || lastObs.valueCoded.conceptId eq patientRefusedConceptId}">		
				<tr>
					<td></td>
			   		<td colspan="3">
			   			<div id="patientDefaultedBackDivId">
				   			<table>
				   				<tr>
				   					<td colspan="3">
				   						<input type="checkbox" name="enrollInHivProgram" id="enrollInHivProgramId" checked="checked" disabled="disabled"/>
			   							<label for="enrollInHivProgramId"><spring:message code="tracpatienttransfer.resumeCare.enrollInHIVProgram"/></label>
				   					</td>
				   				</tr>
				   				<tr>
				   					<td><spring:message code="tracpatienttransfer.resumeCare.enrollment.date"/></td>
				   					<td><input id="enrollmentDate" name="enrollmentDate" value="" size="11" type="text" onclick="showCalendar(this)" autocomplete="off" /></td>
				   					<td><span id="enrollmentDateError"></span></td>
				   				</tr>
				   			</table>
			   			</div>
			   		</td>
			  	</tr>
			</c:if>
		  	<tr>
		  		<td></td>
		  		<td></td>
		  		<td>
		  			<input id="btSave" type="button" onclick="fxSave();" value='<spring:message code="general.save"/>'/>
		  			<input id="btCancel" type="button" onclick="fxCancel();" value='<spring:message code="general.cancel"/>'/>
		  		</td>
				<td></td>
		  	</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	$j(document).ready(function(){
		
		$j("#resumeCareReasonId").change( function() {
			if ($j("#resumeCareReasonId").val()=="<spring:message code='tracpatienttransfer.reason.resumeCare.error'/>") {
				$j("#voidEncounterDivId").show(200);
				$j("#patientDefaultedBackDivId").hide(200);
	        }else {
				$j("#voidEncounterDivId").hide();
				if ($j("#resumeCareReasonId").val()=="<spring:message code='tracpatienttransfer.reason.resumeCare.defaulted.return'/>") {
					$j("#patientDefaultedBackDivId").show(200);
				}else $j("#patientDefaultedBackDivId").hide(200);
	        }
		});		
		
	});
</script>

<script type="text/javascript">

	function fxCancel(){
		self.close();
		window.opener.location.reload();
	}

	function fxSave(){
		if (validateFields()){

			var msg="<spring:message code='tracpatienttransfer.general.message.confirm.save'/>";
			
			if (confirm(msg)) {
				document.resumeCareForm.submit();
		    }
		}
	}

	function backToParent(){
		if ($j("#prtSave").val()=="true"){
			$j("#formTransfer").html("<div onclick='fxCancel()' id='savedDiv'> <spring:message code='tracpatienttransfer.general.careresumed'/> </div>");
			setTimeout(fxCancel,2000);
		}
	}
	backToParent();

	function validateFields(){
		var valid=true;

		if($j("#resumeCareReasonId").val()=="<spring:message code='tracpatienttransfer.reason.resumeCare.defaulted.return'/>"){
			if($j("#enrollmentDate").val()==''){
				$j("#enrollmentDateError").html("*");
				$j("#enrollmentDateError").addClass("error");
				valid=false;
			} else {
				$j("#enrollmentDateError").html("");
				$j("#enrollmentDateError").removeClass("error");
			}
		}
		
		/*if($j("#reasonPatientExitedCareId").val()==$j("#patientDeadConceptId").val()){
			if($j("#dateOfDeath").val()==''){
				$j("#dateOfDeathError").html("*");
				$j("#dateOfDeathError").addClass("error");
				valid=false;
			} else {
				$j("#dateOfDeathError").html("");
				$j("#dateOfDeathError").removeClass("error");
			}

			if($j("#causeOfDeathId").val()=='0'){
				$j("#causeOfDeathError").html("*");
				$j("#causeOfDeathError").addClass("error");
				valid=false;
			} else {
				$j("#causeOfDeathError").html("");
				$j("#causeOfDeathError").removeClass("error");
			
		}}*/

		if(!valid){
			$j("#errorDivNewId").addClass("error");
			/*if(sameLoc){
				$j("#errorDivNewId").html("[ * ]  These fields are required, fill all of them before submitting."
						+"<br/>[ ** ]  Location_from and Location_to cannot be the same.");
			}else */
				$j("#errorDivNewId").html("[ * ]  These fields are required, fill all of them before submitting.");
		} else {
			$j("#errorDivNewId").html("");
			$j("#errorDivNewId").removeClass("error");
		}
		
		return valid;
	}

</script>

<%@ include file="/WEB-INF/template/footer.jsp"%>