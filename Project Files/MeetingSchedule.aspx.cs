using FirstProject.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FirstProject.App_Start;
namespace FirstProject
{
    public partial class MeetingSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {}


        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static List<MeetingScheduleModel> GetMeetingSchedule()
        {
            List<MeetingScheduleModel> List = new List<MeetingScheduleModel>();
            try
            {
                Db db = new Db();
                SqlParameter[] sParams = new SqlParameter[1];
                sParams[0] = new SqlParameter("@facultyId", Convert.ToInt32(HttpContext.Current.User.Identity.Name));
                DataTable MeetingScheduleDetails = db.executeProcedure("GetMeetingSchedule", sParams, true).Tables[0];

                foreach (DataRow dr in MeetingScheduleDetails.Rows)
                {
                    MeetingScheduleModel obj = new MeetingScheduleModel();
                    obj.ScheduleId =  Convert.ToInt32(dr["ScheduleId"].ToString());
                    obj.facultyId = Convert.ToInt32(dr["facultyId"].ToString());
                    obj.FirstName = dr["FirstName"].ToString();
                    obj.LastName = dr["LastName"].ToString();
                    obj.Email = dr["Email"].ToString();
                    obj.AppointmentDate = Convert.ToDateTime(dr["AppointmentDate"].ToString());
                    obj.Time = dr["Time"].ToString();
                    obj.CourseId = Convert.ToInt32(dr["CourseId"].ToString());
                    obj.Purpose = dr["Purpose"].ToString();
                    obj.Comments = dr["Comments"].ToString();
                    obj.IsActive = Convert.ToBoolean(dr["IsActive"].ToString());
                    obj.EventStatus = dr["EventStatus"].ToString();
                    List.Add(obj);
                }
            }
            catch
            {
            }
            return List;
        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public static DropDownListData GetCourse()
        {
            Db db = new Db();
            DropDownListData Data = new DropDownListData();


            SqlParameter[] sParams = new SqlParameter[1];
            sParams[0] = new SqlParameter("@Id", Convert.ToInt32(HttpContext.Current.User.Identity.Name));
            DataRow FacultyDetails = db.executeProcedure("GetFacultyDetailsById", sParams, true).Tables[0].Rows[0];

            List<string> IntervalList = new List<string>();

            var startTime = DateTime.Parse(FacultyDetails["AvaiblityFrom"].ToString());
            var endTime = DateTime.Parse(FacultyDetails["AvaiblityTo"].ToString());

            //var endTime = startTime.AddHours(9);
            while (startTime <= endTime)
            {
                IntervalList.Add(startTime.ToString("hh:mm tt"));
                startTime = startTime.AddMinutes(Convert.ToInt32(FacultyDetails["Interval"].ToString()));

            }

            Data.TimeInterval = IntervalList;

            List<Course> CourseList = new List<Course>();
            try
            {


                DataTable MeetingScheduleDetails = db.executeProcedure("GetCourse", null, true).Tables[0];

                foreach (DataRow dr in MeetingScheduleDetails.Rows)
                {
                    Course obj = new Course();
                    obj.id = Convert.ToInt32(dr["CourseId"].ToString());
                    obj.text = dr["CourseName"].ToString();

                    CourseList.Add(obj);
                }

            }
            catch
            {

            }
            Data.Courses = CourseList;
            return Data;
        }


        [WebMethod]
        public static string InsertUpdateMeetingSchedule(MeetingScheduleModel Data)
        {
            List<MeetingScheduleModel> List = new List<MeetingScheduleModel>();


            TimeSpan time = DateTime.Parse(Data.Time).TimeOfDay;
            DateTime calendarDate = Data.AppointmentDate;
            calendarDate = calendarDate.Add(time);

            TimeSpan diff = calendarDate - DateTime.Now;
            double hours = diff.TotalHours;

            if (hours <= 4)
            {
                return "Meeting Schedule minimum 4 hours in advance ";
            }
            else if (hours >= 24)
            {
                return "Meeting Schedule most 24 hours in advance";
            }

            try
            {

                Db db = new Db();
                SqlParameter[] sParams = new SqlParameter[11];
                sParams[0] = new SqlParameter("@ScheduleId", Data.ScheduleId);
                sParams[1] = new SqlParameter("@facultyId", Convert.ToInt32(HttpContext.Current.User.Identity.Name));
                sParams[2] = new SqlParameter("@FirstName", Data.FirstName);
                sParams[3] = new SqlParameter("@LastName", Data.LastName);
                sParams[4] = new SqlParameter("@Email", Data.Email);
                sParams[5] = new SqlParameter("@AppointmentDate", Data.AppointmentDate);
                sParams[6] = new SqlParameter("@Time", Data.Time);
                sParams[7] = new SqlParameter("@CourseId", Data.CourseId);
                sParams[8] = new SqlParameter("@Purpose", Data.Purpose);
                sParams[9] = new SqlParameter("@Comments", Data.Comments);
                sParams[10] = new SqlParameter("@IsActive", Data.IsActive);


                int ScheduleId = db.executeScheduleProcedureWithId("InsertUpdateMeetingSchedule", sParams);


                //send email to Faculty and Student

                string GetUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                //send email to Faculty
                EmailCls.SendMail("AcceptOrRejectEmail", ScheduleId, "faculty", GetUrl);

                //send email to Student
                EmailCls.SendMail("AcceptOrRejectEmail", ScheduleId, "student", GetUrl);
                return "Success";
            }
            catch (Exception ex)
            {

            }

            return "Error";
        }
    }
}