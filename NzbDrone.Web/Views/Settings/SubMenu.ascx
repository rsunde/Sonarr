﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<dynamic>" %>

    <%
        Html.Telerik().Menu().Name("Menu").Items(items =>
                                                     {
                                                         items.Add().Text("General").Action("General", "Settings");
                                                         items.Add().Text("Indexers").Action("Indexers", "Settings");
                                                         items.Add().Text("Downloads").Action("Downloads", "Settings");
                                                         items.Add().Text("Quality").Action("Quality", "Settings");
                                                         items.Add().Text("Episode Sorting").Action("EpisodeSorting",
                                                                                                    "Settings");
                                                         items.Add().Text("Notifications").Action("Notifications",
                                                                                                  "Settings");
                                                     }).Render();
%>

        