<%-----------------------------------------------------------------------------
	Copyright (c) 2004 Actuate Corporation and others.
	All rights reserved. This program and the accompanying materials 
	are made available under the terms of the Eclipse Public License v2.0
	which accompanies this distribution, and is available at
	http://www.eclipse.org/legal/epl-2.0.html
	
	Contributors:
		Actuate Corporation - Initial implementation.
-----------------------------------------------------------------------------%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page session="false" buffer="none" %>
<%@ page import="org.eclipse.birt.report.context.ScalarParameterBean,
				 org.eclipse.birt.report.context.BaseAttributeBean,
				 org.eclipse.birt.report.utility.ParameterAccessor" %>

<%-----------------------------------------------------------------------------
	Expected java beans
-----------------------------------------------------------------------------%>
<jsp:useBean id="attributeBean" type="org.eclipse.birt.report.context.BaseAttributeBean" scope="request" />

<%-----------------------------------------------------------------------------
	Checkbox parameter control
-----------------------------------------------------------------------------%>
<%
	ScalarParameterBean parameterBean = ( ScalarParameterBean ) attributeBean.getParameterBean( );
	String encodedParameterName = ParameterAccessor.htmlEncode( parameterBean.getName( ) );
%>
<TR>
	<TD NOWRAP>
		<IMG class="icon_parameter" SRC="birt/images/Parameter.png" ALT="<%= parameterBean.getDisplayName( ) %>" TITLE="<%= parameterBean.getToolTip( ) %>"/>
	</TD>
	<TD NOWRAP>
		<SPAN TITLE="<%= parameterBean.getToolTip( ) %>"><LABEL FOR="<%= encodedParameterName %>"><%= parameterBean.getDisplayName( ) %>:</LABEL></SPAN>
		<%-- is required --%>
		<%
		if ( parameterBean.isRequired( ) )
		{
		%>
			<SPAN style="color:red;"><LABEL FOR="<%= encodedParameterName %>">*</LABEL></SPAN>
		<%
		}
		%>
	</TD>
</TR>
<TR>
	<TD NOWRAP></TD>
	<TD NOWRAP WIDTH="100%">
		<%-- Parameter control --%>
		<INPUT TYPE="HIDDEN" ID="control_type" VALUE="checkbox">
		<INPUT TYPE="HIDDEN"
			ID="<%= encodedParameterName + "_hidden" %>"
			NAME="<%= encodedParameterName %>"
			VALUE="<%= parameterBean.getValue( ) %>">
		<INPUT TYPE="CHECKBOX"
			ID="<%= encodedParameterName %>"
			TITLE="<%= parameterBean.getToolTip( ) %>"
			VALUE="<%= encodedParameterName %>"
			<%= "true".equalsIgnoreCase( parameterBean.getValue( ) ) ? "CHECKED" : "" %>
			>
	</TD>
</TR>