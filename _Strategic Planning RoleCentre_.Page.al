page 51111 "Strategic Planning RoleCentre"
{
    Caption = 'Strategy and Perfomance RoleCentre';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part("General Management Cues"; "General Management Cues")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Key Result Areas")
            {
                action("Key Result Areas List")
                {
                    RunObject = page "Key Result Area List";
                }
            }
            group("Strategic Period")
            {
                action("Period")
                {
                    RunObject = page "Strategic Periods";
                }
            }
            group("Perfomance Contracting")
            {
                action("Perfomance Contract Targets")
                {
                    RunObject = page "Perfomance Contract Targets";
                    runpagelink = closed = const(false);
                }
                action("Perfomance Contract Actuals")
                {
                    RunObject = page "Perfomance Contract Actuals";
                    runpagelink = closed = const(false);
                }
                action("Criteria Categories Setup")
                {
                    RunObject = page "Criteria Categories";
                }
                action("Perfomance Contract Setup")
                {
                    RunObject = page "Strategy and Perfomance Setup";
                }
            }
            group(Archive)
            {
                action("Closed Perfomance Contract Targets")
                {
                    RunObject = page "Perfomance Contract Targets";
                    runpagelink = closed = const(true);
                }
                action("Closed Perfomance Contract Actuals")
                {
                    RunObject = page "Perfomance Contract Actuals";
                    runpagelink = closed = const(true);
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
                action("Risk Identification")
                {
                    RunObject = page "Risks List General";
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
            action("Perfomance Quarterly targets")
            {
                RunObject = report "Perfomance Target";
            }
            action("Perfomance Quarterly Targets for SubIndicators")
            {
                RunObject = report "Perfomance Targ SubIndicators";
            }
            action(StrategicPlan)
            {
                Caption = 'Strategic Plan';
                RunObject = report "Strategic Plan";
            }
            action("Performance Contract Report")
            {
                RunObject = report "Quarterly Perfomance Report";
            }
            action("Perfomance Contract Matrix")
            {
                RunObject = report "Perfomance Contract Matrix";
            }
        }
    }
}
