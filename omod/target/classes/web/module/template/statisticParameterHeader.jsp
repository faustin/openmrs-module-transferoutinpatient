<div>
	<form action="advancedSearch.form" method="get" id="form_params">
		<div class="displayListOption">
			<input type="hidden" name="page" id="page_id" value="${(param.page==null || param.page=='')?'1':param.page}"/>
			<table style="width: 100%;">
				<tr>
					<td style="vertical-align: text-top; width: 33%;">
						<span style="margin-left: 5px; display: inline;">
							<table>
								<tr>
									<td><spring:message code="Encounter.location"/></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.location.help"/>"/></td>
									<td><openmrs_tag:locationField formFieldName="location" initialValue="${param.location}" /></td>
								</tr>
								<tr>
									<td><spring:message code="Encounter.provider"/></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.provider.help"/>"/></td>
									<td><select name="provider" id="provider">
							       			<option value="">--</option>
							       			<c:forEach items="${providers}" var="provider">
							       				<option value="${provider.key}" <c:if test="${provider.key==param.provider}">selected='selected'</c:if>>${provider.value}</option>
							       			</c:forEach>
							       		</select>
							       	</td>
								</tr>
								<tr>
									<td>${reasonForExitingCare}</td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.reasonexitcare.help"/>"/></td>
									<td><select name="reasonExitCare" id="reasonPatientExitedCareId">
							       			<option value="">--</option>
							       			<c:forEach items="${exitFromCareReasons}" var="reason">
							       				<option <c:if test="${param.reasonExitCare==reason.key}">selected="selected"</c:if> value="${reason.key}">${reason.value}</option>
							       			</c:forEach>
							       		</select>
							       	</td>
								</tr>
								<!-- <tr>
									<td>${causeOfDeath_title}</td>
									<td><select name="causeOfDeath" id="causeOfDeathId">
								   			<option value=""></option>
								   			<c:forEach items="${causeOfDeathOptions}" var="cause_death">
								   				<option <c:if test="${param.causeOfDeath==cause_death.key}">selected="selected"</c:if> value="${cause_death.key}">${cause_death.value}</option>
								   			</c:forEach>
								   		</select>
									</td>
								</tr> -->
							</table>
						</span>
					</td>
					<td style="width: 33%;">
						<span style="margin-left: 5px; display: inline;">
							<table>
								<tr>
									<td><spring:message code="tracpatienttransfer.search.period"/></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.period.help"/>"/></td>
									<td><spring:message code="tracpatienttransfer.search.from"/> <input value="${param.dateFrom}" type="text" name="dateFrom" size="11" onclick="showCalendar(this);"/> <spring:message code="tracpatienttransfer.search.to"/> <input value="${param.dateTo}" type="text" name="dateTo" size="11" onclick="showCalendar(this);"/></td>
								</tr>
								<tr>
									<td><spring:message code="tracpatienttransfer.search.age"/></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.age.help"/>"/></td>
									<td><spring:message code="tracpatienttransfer.search.from"/> <input value="${param.minAge}" type="text" name="minAge" size="3" style="text-align: right;"/> <spring:message code="tracpatienttransfer.search.years"/> <spring:message code="tracpatienttransfer.search.to"/> <input value="${param.maxAge}" type="text" name="maxAge" size="3" style="text-align: right;"/> <spring:message code="tracpatienttransfer.search.years"/></td>
								</tr>
								<tr>
									<td><spring:message code="tracpatienttransfer.search.gender"/></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.gender.help"/>"/></td>
									<td><select name="gender">
										<option value="">--</option>
										<option value="f" <c:if test="${param.gender=='f'}">selected='selected'</c:if>><spring:message code="tracpatienttransfer.search.gender.female"/></option>
										<option value="m" <c:if test="${param.gender=='m'}">selected='selected'</c:if>><spring:message code="tracpatienttransfer.search.gender.male"/></option>
									</select></td>
								</tr>
								<tr>
									<td><label for="includeVoidedId"><spring:message code="tracpatienttransfer.search.include.voided"/></label></td>
									<td><img border="0" src="<openmrs:contextPath/>/moduleResources/tracpatienttransfer/images/help.gif" title="<spring:message code="tracpatienttransfer.search.includevoided.help"/>"/></td>
									<td><input type="checkbox" name="includeVoided" id="includeVoidedId" <c:if test="${param.includeVoided=='on'}">checked="checked"</c:if>/></td>
								</tr>
							</table>
						</span>
					</td>
				</tr>
			</table>
		</div>
		
		<input class="list_exportBt" style="min-width: 100px;" type="submit" id="bt_submit_id" value="<spring:message code="tracpatienttransfer.refresh"/>"/>
		<br/><br/>
	</form>
	
</div>