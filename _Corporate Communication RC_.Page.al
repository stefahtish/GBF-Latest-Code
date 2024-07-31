page 50364 "Corporate Communication RC"
{
    Caption = 'Corporate Communication';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part("General Management Cues"; "General Management Cues")
            {
                //ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group(Visitors)
            {
                caption = 'Visitor Interactions';

                action("Logged Visitor Interactions")
                {
                    Image = List;
                    RunObject = page Enquiries;
                    RunPageLink = Status = filter(Open);
                }
                action("Officer level Visitor Interactions")
                {
                    Image = List;
                    RunObject = page Enquiries;
                    RunPageLink = Status = filter(Forwarded), "Officer's Decision" = filter(" ");
                }
                action("Rejected Visitor Interactions")
                {
                    Image = List;
                    RunObject = page Enquiries;
                    RunPageLink = "Officer's Decision" = filter(Rejected), Status = filter(Receptionist);
                }
                action("Accepted Visitor Interactions")
                {
                    Image = List;
                    RunObject = page Enquiries;
                    RunPageLink = "Officer's Decision" = filter(Accepted), Status = filter(Receptionist);
                }
                action("Closed Visitor Interactions")
                {
                    Image = List;
                    RunObject = page Enquiries;
                    RunPageLink = Status = filter(Closed);
                }
            }
            group("Customer Relatonship Management")
            {
                group("CRM Interactions Workflow")
                {
                    action("Logged Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(Initial);
                    }
                    action("Department Level Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(Department);
                    }
                    action("HOD level Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(HOD);
                    }
                    action("Escalated Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(Escalated);
                    }
                    action("Corporate Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(Corporate);
                    }
                    action("Closed Client Interactions")
                    {
                        runobject = page "Interaction List";
                        RunPageLink = Stage = filter(Closed);
                    }
                    action(Archive)
                    {
                        Image = List;
                        Caption = 'Archived Client Interactions';
                        RunObject = page "Admin Interactions List";
                    }
                }
            }
            group("Complaints Client Interaction")
            {
                action("Logged Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Complaints Client Interactions")
                {
                    runobject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Closed);
                }
                action(Archives)
                {
                    Image = List;
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Complaints Client Interaction";
                    RunPageLink = Stage = filter(Archived);
                }
            }
            group("Compliments Client Interaction")
            {
                action("Logged Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Compliments Client Interactions")
                {
                    runobject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Closed);
                }
                action(ComplimentsArchives)
                {
                    Image = List;
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Compliment Interaction List";
                    RunPageLink = Stage = filter(Archived);
                }
                // action(Registry)
                // {
                //     Image = List;
                //     Caption = 'Compliments Client Interaction';
                //     RunObject = page "Compliment Interaction List";
                //     Visible = false;
                // }
            }
            group("Enquiry Client Interactions")
            {
                action("Logged Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Enquiry Client Interactions")
                {
                    runobject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Closed);
                }
                action(ArchivedEnquiry)
                {
                    Image = List;
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Enquiry Interactions List";
                    RunPageLink = Stage = filter(Archived);
                }
            }
            group("Observation Client Interaction")
            {
                action("Logged Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Observation Client Interactions")
                {
                    runobject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Closed);
                }
                action(ArchivedObservation)
                {
                    Image = List;
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Observation Client Interaction";
                    RunPageLink = Stage = filter(Archived);
                }
            }
            group("Feedback Client Interaction")
            {
                action("Logged Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Feedback Client Interactions")
                {
                    runobject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Closed);
                }
                action(ArchivedFeedback)
                {
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Feedback Client Interactions";
                    RunPageLink = Stage = filter(Archived);
                }
            }
            group("Request Client Interaction")
            {
                action("Logged Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Initial);
                }
                action("Department Level Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Department);
                }
                action("Escalated Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Escalated);
                }
                action("HOD level Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(HOD);
                }
                action("Corporate Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Corporate);
                }
                action("Closed Request Client Interactions")
                {
                    runobject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Closed);
                }
                action(ArchivedRequest)
                {
                    Image = List;
                    Caption = 'Archived Client Interactions';
                    RunObject = page "Request Client Interaction";
                    RunPageLink = Stage = filter(Archived);
                }
            }
            group("Customer Service")
            {
                action("Client Communication")
                {
                    Image = List;
                    RunObject = page "Client Email/SMS List";
                }
                action("lient Communication - Completed")
                {
                    Image = List;
                    RunObject = page "Client Email/SMS List Complete";
                }
            }
            group("Interaction Setup")
            {
                action("CRM Setup")
                {
                    Image = Setup;
                    RunObject = page "CRM Setup";
                }
                action("Interaction Types")
                {
                    Image = Setup;
                    RunObject = page "Interaction Type List";
                }
                action("Interaction Cause")
                {
                    Image = Setup;
                    RunObject = page "Interaction Cause";
                }
                action("Interaction Escalation Setup")
                {
                    Image = Setup;
                    RunObject = page "Interaction Escalation Setup";
                    Visible = false;
                }
                action("Marketing Setup")
                {
                    Image = Setup;
                    RunObject = page "Marketing Setup";
                }
                action("Interaction Timelines")
                {
                    RunObject = page "Interaction Timelines";
                }
            }
            group("CRM Activities")
            {
                action("Assign Logged Interactions")
                {
                    Image = CoupledUsers;
                    RunObject = codeunit "Claim Assignment";
                }
            }
            group("Self service")
            {
                action(Imprests)
                {
                    RunObject = Page "Imprests-General";
                }
                action("Imprest Surrenders ")
                {
                    RunObject = Page "Imprest Surrenders-General";
                }
                action("Request for payment form")
                {
                    RunObject = page "Payment Form Requests General";
                }
                action("Staff Claim List ")
                {
                    RunObject = Page "Staff Claim List-General";
                }
                action("Purchase Request List ")
                {
                    RunObject = Page "Purchase Request List-General";
                }
                action("Store Request List ")
                {
                    RunObject = Page "Store Request List-General";
                }
                action("Petty Cash")
                {
                    RunObject = page "Petty Cash List-General";
                }
                action("Petty Cash Surrenders")
                {
                    RunObject = page "Petty Cash Surrenders-Gen";
                }
                // action("Leave Applications List")
                // {
                //     RunObject = Page "Leave Application List-General";
                // }
                action("Transport Request")
                {
                    RunObject = Page "Transport requests -General";
                }
                action("Training Requests List ")
                {
                    RunObject = Page "Training Request List-General";
                }
                action("Risk Survey")
                {
                    RunObject = page "Risk Surveys General";
                }
                action("Incident Reporting")
                {
                    RunObject = page "Incident Reports General";
                }
                action("ICT Helpdesk")
                {
                    RunObject = page "ICT Support Incidences General";
                }
                action("Visitor's Interaction Books")
                {
                    RunObject = page "Enquiries General";
                }
            }
        }
        area(Reporting)
        {
            group("CRM Reports")
            {
                action("Turn Around Time Report")
                {
                    Image = Report;
                    RunObject = report "CRM TAT Report";
                }
                action("Client Interactions")
                {
                    Image = Report;
                    RunObject = report "Client Interactions";
                }
                action("Interaction Notes")
                {
                    Image = Report;
                    RunObject = report "Interaction Notes";
                }
                action("Enquiries Report")
                {
                    Image = Report;
                    RunObject = report Enquiries;
                }
                // action("Citizen Service Delivery Dairy ndustry Statistics")
                // {
                //     RunObject = report "Citizen Service Dairy";
                // }
                // action("Citizen Service Delivery Evaluation form import export permits")
                // {
                //     RunObject = report "Citizen Service D Permits";
                // }
                // action("Citizen Service Delivery Evaluation Licenses")
                // {
                //     RunObject = report "Citizen Service D Licenses";
                // }
                // action("Citizen Service Delivery Evaluation LPO")
                // {
                //     RunObject = report "Citizen Service D LPOS";
                // }
                // action("Citizen Service Delivery Evaluation Media Enquiries")
                // {
                //     RunObject = report "Citizen Service D Media";
                // }
                // action("Citizen Service Delivery Milk Carriage")
                // {
                //     RunObject = report "Citizen Service D Milk";
                // }
                action("Citizen Service Delivery Evaluation Resolution of Complaints")
                {
                    RunObject = report "Citizen Service D Complaints";
                }
                // action("Citizen Service Delivery Evaluation Resolution of Enquiries")
                // {
                //     RunObject = report "Citizen Service D Enquiries";
                // }
                action("Visitor Interaction")
                {
                    RunObject = report Enquiries;
                }
            }
        }
    }
}
