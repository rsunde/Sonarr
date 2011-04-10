﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<NzbDrone.Web.Models.NotificationSettingsModel>" %>

<script type="text/javascript">
    $(document).ready(function () {
        var options = {
            target: '#result',
            beforeSubmit: showRequest,
            success: showResponse,
            type: 'post',
            resetForm: false
        };
        $('#form').ajaxForm(options);
        $('#save_button').attr('disabled', '');
    });

    function showRequest(formData, jqForm, options) {
        $("#result").empty().html('Saving...');
        $("#form :input").attr("disabled", true);
    }

    function showResponse(responseText, statusText, xhr, $form) {
        $("#result").empty().html(responseText);
        $("#form :input").attr("disabled", false);
    }                
</script>

    <%
        Html.EnableClientValidation();%>

<%
        using (Html.BeginForm("SaveNotifications", "Settings", FormMethod.Post, new {id = "form", name = "form"}))
        {%>
<%--<%: Html.ValidationSummary(true, "Unable to save your settings. Please correct the errors and try again.") %>--%>

    <fieldset>
        <legend>Notification Settings</legend>      
            
            <fieldset class="sub-field">
                <legend>XBMC</legend>           
                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcEnabled)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcEnabled)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcEnabled)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcNotifyOnGrab)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcNotifyOnGrab)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcNotifyOnGrab)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcNotifyOnDownload)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcNotifyOnDownload)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcNotifyOnDownload)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcNotifyOnRename)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcNotifyOnRename)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcNotifyOnRename)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcNotificationImage)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcNotificationImage)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcNotificationImage)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcDisplayTime)%></div>
                        <div class="config-value"><%=Html.TextBoxFor(m => m.XbmcDisplayTime)%></div>
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcDisplayTime)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcUpdateOnDownload)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcUpdateOnDownload)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcUpdateOnDownload)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcUpdateOnRename)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcUpdateOnRename)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcUpdateOnRename)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcFullUpdate)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcFullUpdate)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcFullUpdate)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcCleanOnDownload)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcCleanOnDownload)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcCleanOnDownload)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcCleanOnRename)%></div>
                        <div class="config-value"><%=Html.CheckBoxFor(m => m.XbmcCleanOnRename)%></div>
                    
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcCleanOnRename)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcHosts)%></div>
                        <div class="config-value"><%=Html.TextBoxFor(m => m.XbmcHosts)%></div>
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcHosts)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcUsername)%></div>
                        <div class="config-value"><%=Html.TextBoxFor(m => m.XbmcUsername)%></div>
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcUsername)%></div>
                </div>

                <div class="config-section">
                    <div class="config-group">
                        <div class="config-title"><%=Html.LabelFor(m => m.XbmcPassword)%></div>
                        <div class="config-value"><%=Html.TextBoxFor(m => m.XbmcPassword)%></div>
                    </div>
                    <div class="config-validation"><%=Html.ValidationMessageFor(m => m.XbmcPassword)%></div>
                </div>
            </fieldset>

            <input type="submit" id="save_button" value="Save" disabled="disabled" />
    
    <%
        }%>
    </fieldset>
<div id="result"></div>