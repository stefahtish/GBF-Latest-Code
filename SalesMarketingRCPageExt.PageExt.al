pageextension 50152 SalesMarketingRCPageExt extends "Sales & Marketing Manager RC"
{
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
        //                 Caption = 'Logged Client Interaction';
        //                 RunObject = page "Logged Client Interaction";
        //             }
        //             action(Registry)
        //             {
        //                 Caption = 'Client Interaction - Registry';
        //                 RunObject = page "Client Interaction - Registry";
        //             }
        //             action(AwaitingAssignment)
        //             {
        //                 Caption = 'Client Interaction - Awaiting Assignment';
        //                 RunObject = page "Client Interactions - Awaiting";
        //             }
        //             action(Assigned)
        //             {
        //                 Caption = 'Assigned Client Interaction';
        //                 RunObject = page "Assigned Client Interaction";
        //             }
        //             action(Escalated)
        //             {
        //                 Caption = 'Escalated Client Interaction';
        //                 RunObject = page "Escalated Client Interaction";
        //             }
        //             action(Closed)
        //             {
        //                 Caption = 'Closed Client Interaction';
        //                 RunObject = page "Closed Client Interaction";
        //             }
        //             action(Admin)
        //             {
        //                 Caption = 'Admin Interactions';
        //                 RunObject = page "Admin Interactions List";
        //             }
        //         }
        //         group("Customer Service")
        //         {
        //             action(Enquiries)
        //             {
        //                 RunObject = page Enquiries;
        //             }
        //             action("Client Email/SMS")
        //             {
        //                 RunObject = page "Client Email/SMS List";
        //             }
        //             action("Client Email/SMS - Completed")
        //             {
        //                 RunObject = page "Client Email/SMS List Complete";
        //             }
        //         }
        //         group("Interaction Setup")
        //         {
        //             action("CRM Setup")
        //             {
        //                 RunObject = page "CRM Setup";
        //             }
        //             action("Interaction Types")
        //             {
        //                 RunObject = page "Interaction Type List";
        //             }
        //             action("Interaction Cause")
        //             {
        //                 RunObject = page "Interaction Cause";
        //             }
        //             action("Interaction Escalation Setup")
        //             {
        //                 RunObject = page "Interaction Escalation Setup";
        //             }
        //         }
        //     }
        //     group("Self service")
        //     {
        //         action(Imprests)
        //         {
        //             RunObject = Page "Imprests-General";
        //         }
        //         action("Imprest Surrenders ")
        //         {
        //             RunObject = Page "Imprest Surrenders-General";
        //         }
        //         action("Request for payment form")
        //         {
        //             RunObject = page "Payment Form Requests General";
        //         }
        //         action("Staff Claim List ")
        //         {
        //             RunObject = Page "Staff Claim List-General";
        //         }
        //         action("Purchase Request List ")
        //         {
        //             RunObject = Page "Purchase Request List-General";
        //         }
        //         action("Store Request List ")
        //         {
        //             RunObject = Page "Store Request List-General";
        //         }
        //         action("Petty Cash")
        //         {
        //             RunObject = page "Petty Cash List-General";
        //         }
        //         action("Petty Cash Surrenders")
        //         {
        //             RunObject = page "Petty Cash Surrenders-Gen";
        //         }
        //         action("Leave Applications List")
        //         {
        //             RunObject = Page "Leave Application List-General";
        //         }
        //         action("Transport Request")
        //         {
        //             RunObject = Page "Transport requests -General";
        //         }
        //         action("Training Requests List ")
        //         {
        //             RunObject = Page "Training Request List-General";
        //         }
        //         action("Risk Survey")
        //         {
        //             RunObject = page "Risk Surveys General";
        //         }
        //         action("Incident Reporting")
        //         {
        //             RunObject = page "Incident Reports General";
        //         }
        //         action("Budget Approval List")
        //         {
        //             RunObject = Page "Budget Approval List";
        //         }
        //     }
        // }
        addlast(Reporting)
        {
            group("CRM Reports")
            {
                action("Turn Around Time Report")
                {
                    RunObject = report "CRM TAT Report";
                    ApplicationArea = All;
                }
                action("Client Interactions")
                {
                    RunObject = report "Client Interactions";
                    ApplicationArea = All;
                }
                action("Interaction Notes")
                {
                    RunObject = report "Interaction Notes";
                    ApplicationArea = All;
                }
                action("Enquiries Report")
                {
                    RunObject = report Enquiries;
                    ApplicationArea = All;
                }
            }
        }
    }
}
