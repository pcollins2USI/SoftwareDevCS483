using FirstProject.App_Start;
using FirstProject.Helper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstProject
{
    public partial class EmailNotification : System.Web.UI.Page
    {

     /// <summary>
     ///
     /// </summary>
     /// <param name="sender"></param>
     /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["type"] != null && Request.QueryString["id"] != null)
            {
                string GetUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);

                string ScheduleId = StringHelper.Decrypt(Request.QueryString["id"].ToString());
                if (Request.QueryString["type"].ToLower() == "accept")
                {
                    EmailAccept(Convert.ToInt32(ScheduleId), 1);
                    //call sp and give message

                    lblmsg.Text = "Meeting has been Scheduled";
                    EmailCls.SendMail("AcceptedEmail",Convert.ToInt32(ScheduleId), "faculty", GetUrl);
                    EmailCls.SendMail("AcceptedEmail", Convert.ToInt32(ScheduleId), "student", GetUrl);
                    //send email to Student after accept invitation
                }
                else if (Request.QueryString["type"].ToLower() == "reject")
                {

                    EmailAccept(Convert.ToInt32(ScheduleId), 2);

                    lblmsg.Text = "Meeting has been Rejected";
                    EmailCls.SendMail("RejectedEmail", Convert.ToInt32(ScheduleId), "faculty", GetUrl);
                    EmailCls.SendMail("RejectedEmail", Convert.ToInt32(ScheduleId), "student", GetUrl);
                    //send email to Student after reject invitation

                    //call sp and give message

                }


            }

        }

        /// <summary>
        ///
        /// </summary>
        /// <param name="ScheduleId"></param>
        /// <param name="Accepted"></param>
        private void EmailAccept(int ScheduleId, int Accepted)
        {


            Db db = new Db();
            SqlParameter[] sParams = new SqlParameter[2];
            sParams[0] = new SqlParameter("@ScheduleId", ScheduleId);
            sParams[1] = new SqlParameter("@Accepted", Accepted);
            db.executeProcedure("MeetingScheduleAccepted", sParams, false);
        }
    }
}