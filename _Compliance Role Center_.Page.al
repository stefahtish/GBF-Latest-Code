page 50511 "Compliance Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control2)
            {
                ShowCaption = false;
            }
            part("Compliance Management Cue"; "Compliance Management Cue")
            {
                ApplicationArea = ALl;
            }
        }
    }
    actions
    {
        area(processing)
        {
        }
        area(sections)
        {
            group("Enforcement")
            {
                caption = 'Enforcement of Dairy Industry Act and Regulations';

                action("Open Enforcement List")
                {
                    RunObject = page "Enforcement List";
                    RunPageLink = Submitted = const(false);
                }
                action("Enforcement List")
                {
                    RunObject = page "Enforcement List";
                    RunPageLink = Submitted = const(true);
                }
            }
            group("Applicant Registrations")
            {
                Image = Departments;
                Visible = false;

                action("Open Applications")
                {
                    RunObject = Page "Applicant Registrations";
                    RunPageLink = Submitted = const(false);
                }
                action("Submitted Applications")
                {
                    RunObject = Page "Applicant Registrations";
                    RunPageLink = Submitted = const(true);
                }
            }
            group("New Permit Applications")
            {
                Image = Departments;

                action("Open Permit Applications")
                {
                    RunObject = Page "Permit Applications";
                    RunPageLink = Submitted = const(false), "Application Type" = const(Application);
                }
                action("Submitted Permit Applications")
                {
                    RunObject = Page "Permit Applications";
                    RunPageLink = Submitted = const(true), "Application Type" = const(Application);
                    //"License and Permit Renewals"
                }
            }
            group("Regulatory Permit Renewals")
            {
                Image = Departments;

                action("Open Permit Renewals")
                {
                    RunObject = Page "Permit Applications";
                    RunPageLink = Submitted = const(false), "Application Type" = const(Renewal);
                }
                action("Submitted Permit Renewals")
                {
                    RunObject = Page "Permit Applications";
                    RunPageLink = Submitted = const(true), "Application Type" = const(Renewal);
                }
            }
            group("Monthly Returns")
            {
                Image = Departments;

                action("Open Returns")
                {
                    RunObject = Page "Monthly Form of Returns";
                    RunPageLink = Submitted = const(false);
                }
                action("Submitted Returns")
                {
                    RunObject = Page "Monthly Form of Returns";
                    RunPageLink = Submitted = const(true);
                }
            }
            group("Regulatory permits categories")
            {
                action("Regulatory Permits")
                {
                    RunObject = Page Licenses;
                }
            }
            group(Setups)
            {
                action(Setup)
                {
                    RunObject = Page "Compliance Setup";
                }
                action("Dairy Produce")
                {
                    RunObject = page "Compliance Products Setup";
                }
                action("Levy")
                {
                    RunObject = page "Cess and Levy setup";
                }
                action("Where found Setup")
                {
                    RunObject = page "Means of Handling Setup";
                }
                action("Mode of Transport Setup")
                {
                    RunObject = page "Vehicle Types Setup";
                }
                action("Reasons for Confiscation Setup")
                {
                    RunObject = page "Reasons for Confiscation Setup";
                }
                action("Monthly Intakes Setup")
                {
                    RunObject = page "Monthly Intakes Setup";
                }
                action("Required Documents")
                {
                    RunObject = page "Required Documents Setup";
                }
                action("Sell to whom setup")
                {
                    RunObject = page "Sale to whom setup";
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
                action("Leave Applications List")
                {
                    RunObject = Page "Leave Application List-General";
                }
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
        area(creation)
        {
            action("Change password")
            {
            }
        }
        area(Reporting)
        {
            action("Enforcements")
            {
                RunObject = report "Enforcements Report";
            }
            action("Enforcements Non-compliances")
            {
                RunObject = report "Enforcements Non-compliances";
            }
            action("Permit Applications")
            {
                RunObject = report "Permit Applications";
            }
            action("Levy Defaulters")
            {
                RunObject = report "Levy Defaulters";
            }
            action("License File")
            {
                RunObject = report "License File";
            }
        }
    }
}
