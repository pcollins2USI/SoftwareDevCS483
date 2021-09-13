using System;
using Gtk;

using Google.Apis.Auth.OAuth2;
using Google.Apis.Calendar.v3;
using Google.Apis.Calendar.v3.Data;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

public partial class MainWindow : Gtk.Window
{

	static string[] Scopes = { CalendarService.Scope.CalendarEvents};
	static string ApplicationName = "Google Calendar API .NET Quickstart";
	UserCredential credential;
	CalendarService _service;
	public string Events
	{
		get;
		set;
	}

	public MainWindow() : base(Gtk.WindowType.Toplevel)
	{
		Build();
		runAuthen();
		_service = new CalendarService(new BaseClientService.Initializer()
        {
            HttpClientInitializer = credential,
            ApplicationName = ApplicationName,
        });
	}

	protected void OnDeleteEvent(object sender, DeleteEventArgs a)
	{
		Application.Quit();
		a.RetVal = true;
	}
	public void runAuthen()
	{


		using (var stream =
		       new FileStream("client_secret.json", FileMode.Open, FileAccess.Read))
		{
			// The file token.json stores the user's access and refresh tokens, and is created
			// automatically when the authorization flow completes for the first time.
			string credPath = "token.json";
			credential = GoogleWebAuthorizationBroker.AuthorizeAsync(
				GoogleClientSecrets.Load(stream).Secrets,
				Scopes,
				"user",
				CancellationToken.None,
				new FileDataStore(credPath, true)).Result;
			Console.WriteLine("Credential file saved to: " + credPath);
		}

		// Create Google Calendar API service.
		var service = new CalendarService(new BaseClientService.Initializer()
		{
			HttpClientInitializer = credential,
			ApplicationName = ApplicationName,
		});

		// Define parameters of request.
		EventsResource.ListRequest request = service.Events.List("primary");
		request.TimeMin = DateTime.Now;
		request.ShowDeleted = false;
		request.SingleEvents = true;
		request.MaxResults = 10;
		request.OrderBy = EventsResource.ListRequest.OrderByEnum.StartTime;

		// List events.
		Events events = request.Execute();
		textview1.Buffer.Text += String.Format("Upcoming events:\n");
		if (events.Items != null && events.Items.Count > 0)
		{
			foreach (var eventItem in events.Items)
			{
				string when = eventItem.Start.DateTime.ToString();
				if (String.IsNullOrEmpty(when))
				{
					when = eventItem.Start.Date;
				}
				textview1.Buffer.Text += String.Format("{0} ({1})\n", eventItem.Summary, when);
				Events += String.Format("{0} ({1}),", eventItem.Summary, when);
			}
		}
		else
		{
			textview1.Buffer.Text += String.Format("No upcoming events found.");
		}

	}
	private void CreateEvent(CalendarService _service)
    {

		var body = new Event
        {
            Summary = "Google I/O 2015",
            Location = "800 Howard St., San Francisco, CA 94103",
            Description = "A chance to hear more about Google's developer products.",
            Start = new EventDateTime()
            {
                DateTime = DateTime.Parse("2021-09-14T12:15:00-05:00"),
				TimeZone = "America/Chicago",
            },
            End = new EventDateTime()
            {
                DateTime = DateTime.Parse("2021-09-14T12:30:00-05:00"),
				TimeZone = "America/Chicago",
            },
            //Recurrence = new String[] { "RRULE:FREQ=WEEKLY;BYDAY=MO" },
            Attendees = new List<EventAttendee>
            {
                new EventAttendee { Email = "pcollins2@eagles.usi.edu"}
            },
        };
		Event newEvent = new Event()
        {
            Summary = "Google I/O 2015",
            Location = "800 Howard St., San Francisco, CA 94103",
            Description = "A chance to hear more about Google's developer products.",
            Start = new EventDateTime()
            {
                DateTime = DateTime.Parse("2015-05-28T09:00:00-07:00"),
                TimeZone = "America/Los_Angeles",
            },
            End = new EventDateTime()
            {
                DateTime = DateTime.Parse("2015-05-28T17:00:00-07:00"),
                TimeZone = "America/Los_Angeles",
            },
            Recurrence = new String[] { "RRULE:FREQ=DAILY;COUNT=2" },
            Attendees = new EventAttendee[] {
        new EventAttendee() { Email = "lpage@example.com" },
        new EventAttendee() { Email = "sbrin@example.com" },
    },
            Reminders = new Event.RemindersData()
            {
                UseDefault = false,
                Overrides = new EventReminder[] {
            new EventReminder() { Method = "email", Minutes = 24 * 60 },
            new EventReminder() { Method = "sms", Minutes = 10 },
        }
            }
        };
  //      Event body = new Event();
  //      EventAttendee a = new EventAttendee();
  //      a.Email = "pcollins2@eagles.usi.edu";
  //      List<EventAttendee> attendes = new List<EventAttendee>();
  //      attendes.Add(a);
  //      body.Attendees = attendes;
  //      EventDateTime start = new EventDateTime();
  //      start.DateTime = Convert.ToDateTime("2021-09-13T012:15:00+0530");
  //      EventDateTime end = new EventDateTime();
  //      end.DateTime = Convert.ToDateTime("2021-09-13T12:30:00+0530");
		//var curTZone = TimeZone.CurrentTimeZone;
        //var dateStart = new DateTimeOffset(start, curTZone.GetUtcOffset(start));
        //var dateEnd = new DateTimeOffset(end, curTimeZone.GetUtcOffset(end));
        //var startTimeString = dateStart.ToString("o");
        //var endTimeString = dateEnd.ToString("o");

        //evnt.Start = new EventDateTime()
        //{
        //    DateTime = startTimeString
        //};
        
        //evnt.End = new EventDateTime()
        //{
        //    DateTime = endTimeString
        //};
        //body.Start = start;
        //body.End = end;
        //body.Location = "Some Professor Office";
        //body.Summary = "Discussion about Assignment 1";
        //EventsResource.InsertRequest request = new EventsResource.InsertRequest(_service, body, "patrickdcollinspdc@gmail.com");
		String calendarId = "primary";
		EventsResource.InsertRequest request = _service.Events.Insert(body, calendarId);
        Event response = request.Execute();
    }
	protected void ShowEvents(object sender, EventArgs e)
	{
		int selectedDay = calendar1.Day;
		string[] eachEvents = Events.Split(',');
		foreach (var item in eachEvents)
		{
			Console.WriteLine(item);
			//Console.WriteLine(item.Split('(')[1].Replace(' ',','));
		}
	}

	protected void createEventBt(object sender, EventArgs e)
	{ 
		const string dataFmt = "{0,-30}{1}";
        const string timeFmt = "{0,-30}{1:MM-dd-yyyy HH:mm}";
        TimeZone curTimeZone = TimeZone.CurrentTimeZone;
        // What is TimeZone name?  
        Console.WriteLine(dataFmt, "TimeZone Name:", curTimeZone.StandardName);
        // Is TimeZone DayLight Saving?|  
        Console.WriteLine(dataFmt, "Daylight saving time?", curTimeZone.IsDaylightSavingTime(DateTime.Now));
        // What is GMT (also called Coordinated Universal Time (UTC)  
        DateTime curUTC = curTimeZone.ToUniversalTime(DateTime.Now);
        Console.WriteLine(timeFmt, "Coordinated Universal Time:", curUTC);
        // What is GMT/UTC offset ?  
        TimeSpan currentOffset = curTimeZone.GetUtcOffset(DateTime.Now);
        Console.WriteLine(dataFmt, "UTC offset:", currentOffset);
        // Get DaylightTime object  
        System.Globalization.DaylightTime dl = curTimeZone.GetDaylightChanges(DateTime.Now.Year);
        // DateTime when the daylight-saving period begins.  
        Console.WriteLine("Start: {0:MM-dd-yyyy HH:mm} ", dl.Start);
        // DateTime when the daylight-saving period ends.  
        Console.WriteLine("End: {0:MM-dd-yyyy HH:mm} ", dl.End);
        // Difference between standard time and the daylight-saving time.  
        Console.WriteLine("delta: {0}", dl.Delta);
		try
		{
			CreateEvent(_service);
		}
		catch (Exception ex)
		{
			textview1.Buffer.Text += String.Format("Failed to create! Error: {0}", ex);
		}

	}
}

