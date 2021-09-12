using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstProject
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Session["UserId"] = TextBox1.Text;


            CalendarService _service = this.GetCalendarService(@"C:\\Users\\smitd\\Downloads\\test.json");
            GetEvents(_service);
//            CreateEvent(_service);


        }

        private CalendarService GetCalendarService(string keyfilepath)
        {
            try
            {
                string[] Scopes = {
                   CalendarService.Scope.Calendar,
                   CalendarService.Scope.CalendarEvents,
                   CalendarService.Scope.CalendarEventsReadonly
                  };

                UserCredential credential;

                using (var stream =
                  new FileStream(keyfilepath, FileMode.Open, FileAccess.Read))
                {
                    // The file token.json stores the user's access and refresh tokens, and is created
                    // automatically when the authorization flow completes for the first time.

                    string credPath = @"C:\\Users\\smitd\\Downloads\\token.json";
                    credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
                        GoogleClientSecrets.FromStream(stream).Secrets,
                        Scopes,
                        "user",
                        CancellationToken.None,
                        new FileDataStore(credPath, true)).Result;
                    Console.WriteLine("Credential file saved to: " + credPath);
                }



                // Create Calendar API service.
                var service = new CalendarService(new BaseClientService.Initializer()
                {
                    HttpClientInitializer = credential,
                    ApplicationName = "primary",
                });

                return service;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private void GetEvents(CalendarService _service)
        {
            // Define parameters of request.
            EventsResource.ListRequest request = _service.Events.List("primary");
            request.TimeMin = DateTime.Now;
            request.ShowDeleted = false;
            request.SingleEvents = true;
            request.MaxResults = 10;
            request.OrderBy = EventsResource.ListRequest.OrderByEnum.StartTime;

            // List events.
            Events events = request.Execute();
            Console.WriteLine("Upcoming events:");
            if (events.Items != null && events.Items.Count > 0)
            {
                foreach (var eventItem in events.Items)
                {
                    string when = eventItem.Start.DateTime.ToString();
                    if (String.IsNullOrEmpty(when))
                    {
                        when = eventItem.Start.Date;
                    }
                }
            }
            else
            {
            }
        }
        private void CreateEvent(CalendarService _service)
        {


            var ev = new Event();
            List<EventAttendee> attendes = new List<EventAttendee>();

            EventAttendee a = new EventAttendee();
            a.Email = "pcane@gmail.com";
            attendes.Add(a);

            EventDateTime start = new EventDateTime();
            start.DateTime = new DateTime(2021, 10, 11, 10, 0, 0);

            EventDateTime end = new EventDateTime();
            end.DateTime = new DateTime(2021, 10, 11, 10, 30, 0);

            ev.Attendees = attendes;
            ev.Start = start;
            ev.End = end;

            ev.Summary = "New Event Update 1234";
            ev.Description = "Description...";
            var calendarId = "primary";
            //Event recurringEvent = _service.Events.Update(ev, calendarId, "i5vgpdpp6cvjnr5le6i76pjrm0").Execute();
            Event recurringEvent = _service.Events.Insert(ev, calendarId).Execute();
        }
    }
}