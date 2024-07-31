page 50218 "Fleet Management RC"
{
    Caption = 'Fleet Management RC';
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
            group("Transport Management")
            {
                action("Fleet List")
                {
                    Visible = false;
                    RunObject = Page "Fleet List";
                }
                action("Transport Requests List")
                {
                    RunObject = Page "Trip Listing";
                    RunPageLink = Status = filter(Open);
                }
                action("Pending Transport Requests List")
                {
                    RunObject = Page "Trip Listing";
                    RunPageLink = Status = filter("Pending Approval");
                }
                action("Approved Transport Requests")
                {
                    RunObject = Page "Trip Listing";
                    RunPageLink = Status = filter(Released), "Transport Status" = filter(<> Completed);
                }
            }
            group(DriverLogging)
            {
                Caption = 'Driver Logging';

                action("Open Driver Loggings")
                {
                    RunObject = page "Driver Logging Sheet";
                    RunPageLink = Submitted = const(false);
                }
                action("Submitted Driver Loggings")
                {
                    RunObject = page "Driver Logging Sheet";
                    RunPageLink = Submitted = const(true);
                }
            }
            group("Driver Incident Logging")
            {
                action("Incidents")
                {
                    RunObject = page "Transport incidents";
                    RunPageLink = Reported = const(false);
                }
                action("Reported Incidents")
                {
                    RunObject = page "Transport incidents";
                    RunPageLink = Reported = const(true);
                }
            }
            group(FuelAllocation)
            {
                Caption = 'Fuel Allocation';

                action("Open Fuel Allocations")
                {
                    RunObject = page "Fuel Allocations";
                    RunPageLink = Allocated = const(false);
                }
                action("Fuel Allocations")
                {
                    RunObject = page "Fuel Allocations";
                    RunPageLink = Allocated = const(true);
                }
                action("Fuel Allocation Period")
                {
                    RunObject = page "Fuel Allocation Periods";
                }
            }
            group(FuelTransfer)
            {
                Caption = 'Fuel Transfer';

                action("Open Fuel Transfer")
                {
                    RunObject = page "Fuel Transfer";
                    RunPageLink = Transferred = const(false);
                }
                action("Fuel Transfers")
                {
                    RunObject = page "Fuel Transfer";
                    RunPageLink = Transferred = const(true);
                }
            }
            // group("Maintenance Request")
            // {
            //     action("Maintenance Request List")
            //     {
            //         RunObject = page "Maintenance Request List";
            //         RunPageLink = Status = filter(<> Approved);
            //     }
            //     action("Asset Maintenance Request List")
            //     {
            //         RunObject = page "Asset Maintenance Request List";
            //         RunPageLink = Status = filter(<> Approved);
            //     }
            // }
            group("Transport Management Archive")
            {
                action("Completed Travels")
                {
                    RunObject = Page "Completed Travels";
                }
                // action("Approved Maintenance Request List")
                // {
                //     RunObject = page "Maintenance Request List";
                //     RunPageLink = Status = const(Approved);
                // }
                // action("Approved Asset Maintenance Request List")
                // {
                //     RunObject = page "Asset Maintenance Request List";
                //     RunPageLink = Status = const(Approved);
                // }
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
                action("Visitor's Interaction Books")
                {
                    RunObject = page "Enquiries General";
                }
            }
        }
    }
}
