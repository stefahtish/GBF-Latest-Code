pageextension 50153 SalesRelationshipMgrRCPageExt extends "Sales & Relationship Mgr. RC"
{
    Caption = 'Corporate Communication';

    actions
    {
        // addlast(Sections)
        // {
        //     group("Customer Relatonship Management")
        //     {
        //         group("CRM Interactions Workflow")
        //         {
        //             action(Logged)
        //             {
        //                 Image = List;
        //                 Caption = 'Logged Client Interaction';
        //                 RunObject = page "Logged Client Interaction";
        //             }
        //             action(Registry)
        //             {
        //                 Image = List;
        //                 Caption = 'Client Interaction - Registry';
        //                 RunObject = page "Client Interaction - Registry";
        //                 Visible = false;
        //             }
        //             action(AwaitingAssignment)
        //             {
        //                 Image = List;
        //                 Caption = 'Client Interaction - Awaiting Assignment';
        //                 RunObject = page "Client Interactions - Awaiting";
        //             }
        //             action(Assigned)
        //             {
        //                 Image = List;
        //                 Caption = 'Assigned Client Interaction';
        //                 RunObject = page "Assigned Client Interaction";
        //             }
        //             action(Escalated)
        //             {
        //                 Image = List;
        //                 Caption = 'Escalated Client Interaction';
        //                 RunObject = page "Escalated Client Interaction";
        //             }
        //             action(Closed)
        //             {
        //                 Image = List;
        //                 Caption = 'Closed Client Interaction';
        //                 RunObject = page "Closed Client Interaction";
        //             }
        //             action(Admin)
        //             {
        //                 Image = List;
        //                 Caption = 'Admin Interactions';
        //                 RunObject = page "Admin Interactions List";
        //             }
        //         }
        //         group("Customer Service")
        //         {
        //             action(Enquiries)
        //             {
        //                 Image = List;
        //                 RunObject = page Enquiries;
        //             }
        //             action("Client Email/SMS")
        //             {
        //                 Image = List;
        //                 RunObject = page "Client Email/SMS List";
        //             }
        //             action("Client Email/SMS - Completed")
        //             {
        //                 Image = List;
        //                 RunObject = page "Client Email/SMS List Complete";
        //             }
        //         }
        //         group("Interaction Setup")
        //         {
        //             action("CRM Setup")
        //             {
        //                 Image = Setup;
        //                 RunObject = page "CRM Setup";
        //             }
        //             action("Interaction Types")
        //             {
        //                 Image = Setup;
        //                 RunObject = page "Interaction Type List";
        //             }
        //             action("Interaction Cause")
        //             {
        //                 Image = Setup;
        //                 RunObject = page "Interaction Cause";
        //             }
        //             action("Interaction Escalation Setup")
        //             {
        //                 Image = Setup;
        //                 RunObject = page "Interaction Escalation Setup";
        //                 Visible = false;
        //             }
        //             action("Marketing Setup")
        //             {
        //                 Image = Setup;
        //                 RunObject = page "Marketing Setup";
        //             }
        //         }
        //         group("CRM Activities")
        //         {
        //             action("Assign Logged Interactions")
        //             {
        //                 Image = CoupledUsers;
        //                 RunObject = codeunit "Claim Assignment";
        //             }
        //         }
        //         group("Self service")
        //         {
        //             action(Imprests)
        //             {
        //                 RunObject = Page "Imprests-General";
        //             }
        //             action("Imprest Surrenders ")
        //             {
        //                 RunObject = Page "Imprest Surrenders-General";
        //             }
        //             action("Staff Claim List ")
        //             {
        //                 RunObject = Page "Staff Claim List-General";
        //             }
        //             action("Purchase Request List ")
        //             {
        //                 RunObject = Page "Purchase Request List-General";
        //             }
        //             action("Store Request List ")
        //             {
        //                 RunObject = Page "Store Request List-General";
        //             }
        //             action("Petty Cash")
        //             {
        //                 RunObject = page "Petty Cash List-General";
        //             }
        //             action("Petty Cash Surrenders")
        //             {
        //                 RunObject = page "Petty Cash Surrenders-Gen";
        //             }
        //             action("Leave Applications List")
        //             {
        //                 RunObject = Page "Leave Application List-General";
        //             }
        //             action("Transport Request")
        //             {
        //                 RunObject = Page "Transport requests -General";
        //             }
        //             action("Training Requests List ")
        //             {
        //                 RunObject = Page "Training Request List-General";
        //             }
        //             action("Risk identification")
        //             {
        //                 RunObject = page "Risks List General";
        //             }
        //             action("Risk Survey")
        //             {
        //                 RunObject = page "Risk Surveys General";
        //             }
        //             action("Incident Reporting")
        //             {
        //                 RunObject = page "Incident Reports General";
        //             }
        //             action("Budget Approval List")
        //             {
        //                 RunObject = Page "Budget Approval List";
        //             }
        //         }
        //     }
        // }
        addlast(Reporting)
        {
            group("CRM Reports")
            {
                action("Turn Around Time Report")
                {
                    Image = Report;
                    RunObject = report "CRM TAT Report";
                    ApplicationArea = All;
                }
                action("Client Interactions")
                {
                    Image = Report;
                    RunObject = report "Client Interactions";
                    ApplicationArea = All;
                }
                action("Interaction Notes")
                {
                    Image = Report;
                    RunObject = report "Interaction Notes";
                    ApplicationArea = All;
                }
                action("Enquiries Report")
                {
                    Image = Report;
                    RunObject = report Enquiries;
                    ApplicationArea = All;
                }
            }
        }
    }
}
