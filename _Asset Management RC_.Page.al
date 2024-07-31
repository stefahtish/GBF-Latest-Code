page 50219 "Asset Management RC"
{
    Caption = 'Asset Management RC';
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
            group("Group42")
            {
                Caption = 'Fixed Assets';

                action("Fixed Assets12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Assets List";
                }
                action("Fleet management")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Vehicle Registration';
                    RunObject = page "Fleet List";
                }
                action("Maintenance Request")
                {
                    RunObject = page "Maintenance Request List";
                    RunPageLink = Archive = const(false);
                }
                action("Asset Maintenance Request List")
                {
                    RunObject = page "Asset Maintenance Request List";
                    RunPageLink = Archive = const(false);
                }
                action("Maintenance and Repair")
                {
                    RunObject = Page "Maintenance Registration";
                }
                group("Asset Allocations")
                {
                    action("Open Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Approval Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Asset Allocation")
                    {
                        RunObject = page "Asset Allocation List";
                        RunPageLink = Status = filter(Released), Allocated = const(false);
                    }
                }
                group("Asset Transfers")
                {
                    action("Asset Transfer")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Approval Asset Transfers")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Asset Transfers")
                    {
                        RunObject = page "Asset Transfer List";
                        RunPageLink = Status = filter(Released), Transferred = const(false);
                    }
                }
                action("Insurance12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = page "Insurance List";
                }
                action("Calculate Depreciation...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation...';
                    RunObject = report "Calculate Depreciation";
                }
                action("Fixed Assets...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Fixed Assets...';
                    RunObject = report "Index Fixed Assets";
                }
                action("Insurance...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Insurance...';
                    RunObject = report "Index Insurance";
                }
            }
            group("Fixed Asset Disposal")
            {
                group("Asset Disposal Plan")
                {
                    action("Open Annual Disposal Plan")
                    {
                        RunObject = page "Annual Asset Disposal Plan";
                        RunPageLink = Status = const(open);
                    }
                    action("Pending Annual Disposal Plan")
                    {
                        RunObject = page "Annual Asset Disposal Plan";
                        RunPageLink = Status = const("Pending Approval");
                    }
                    action("Annual Asset Disposal Plan")
                    {
                        RunObject = page "Annual Asset Disposal Plan";
                        RunPageLink = Status = const(Approved);
                    }
                }
                group("Asset Disposal Tenders")
                {
                    action("FA Disposal")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = filter(<> Approved);
                    }
                    action("FA Disposal-Approved")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = const(Approved), "Quote generated" = const(false);
                    }
                    action("FA Disposal-archived")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = const(Approved), "Quote generated" = const(false);
                    }
                }
                group("Asset Disposal Committee")
                {
                    action("Open Asset Disposal Committee")
                    {
                        RunObject = page "Asset Disposal Committee";
                        RunPageLink = Status = filter(Open);
                    }
                    action("Pending Asset Disposal Committee")
                    {
                        RunObject = page "Asset Disposal Committee";
                        RunPageLink = Status = filter("Pending Approval");
                    }
                    action("Approved Asset Disposal Committee")
                    {
                        RunObject = page "Asset Disposal Committee";
                        RunPageLink = Status = filter(Released);
                    }
                }
                action("Fixed Assets Marked For Disposal")
                {
                    Image = Bin;
                    RunObject = page "FA Marked For Disposal List";
                }
            }
            group("FA Disposal Quotes")
            {
                action("FA Quotation List")
                {
                    RunObject = page "FA Disposal Quote List";
                }
            }
            group("Prospective Customers")
            {
                action("Prospective Customer List")
                {
                    RunObject = page "Prospective Customer List";
                }
            }
            group("Group43")
            {
                Caption = 'Journals';

                action("G/L Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA G/L Journals';
                    RunObject = page "Fixed Asset G/L Journal";
                }
                action("FA Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Journals';
                    RunObject = page "Fixed Asset Journal";
                }
                action("FA Reclass. Journal")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Reclassification Journals';
                    RunObject = page "FA Reclass. Journal";
                }
                action("Insurance Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journals';
                    RunObject = page "Insurance Journal";
                }
                action("Recurring Journals1")
                {
                    ApplicationArea = Suite, FixedAssets;
                    Caption = 'Recurring General Journals';
                    RunObject = page "Recurring General Journal";
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = page "Recurring Fixed Asset Journal";
                }
            }
            group("Group44")
            {
                Caption = 'Reports';

                group("Group45")
                {
                    Caption = 'Fixed Assets';

                    action("Posting Group - Net Change")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Posting Group - Net Change';
                        RunObject = report "FA Posting Group - Net Change";
                    }
                    action("Register1")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Register';
                        RunObject = report "Fixed Asset Register";
                    }
                    action("Acquisition List")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Acquisition List';
                        RunObject = report "Fixed Asset - Acquisition List";
                    }
                    action("Analysis1")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Analysis';
                        RunObject = report "Fixed Asset - Analysis";
                    }
                    action("Book Value 01")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Book Value 01';
                        RunObject = report "Fixed Asset - Book Value 01";
                    }
                    action("Book Value 02")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Book Value 02';
                        RunObject = report "Fixed Asset - Book Value 02";
                    }
                    action("Details")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Details';
                        RunObject = report "Fixed Asset - Details";
                    }
                    action("G/L Analysis")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA G/L Analysis';
                        RunObject = report "Fixed Asset - G/L Analysis";
                    }
                    action("List1")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA List';
                        RunObject = report "Fixed Asset - List";
                    }
                    action("Projected Value")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Projected Value';
                        RunObject = report "Fixed Asset - Projected Value";
                    }
                }
                group("Group46")
                {
                    Caption = 'Insurance';

                    action("Uninsured FAs")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Uninsured FAs';
                        RunObject = report "Insurance - Uninsured FAs";
                    }
                    action("Register2")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Register';
                        RunObject = report "Insurance Register";
                    }
                    action("Analysis2")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Analysis';
                        RunObject = report "Insurance - Analysis";
                    }
                    action("Coverage Details")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Coverage Details';
                        RunObject = report "Insurance - Coverage Details";
                    }
                    action("List2")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance List';
                        RunObject = report "Insurance - List";
                    }
                    action("Tot. Value Insured")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Total Value Insured';
                        RunObject = report "Insurance - Tot. Value Insured";
                    }
                }
                group("Group47")
                {
                    Caption = 'Maintenance';

                    action("Register3")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Register';
                        RunObject = report "Maintenance Register";
                    }
                    action("Analysis3")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Analysis';
                        RunObject = report "Maintenance - Analysis";
                    }
                    action("Details1")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Details';
                        RunObject = report "Maintenance - Details";
                    }
                    action("Next Service")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Next Service';
                        RunObject = report "Maintenance - Next Service";
                    }
                }
            }
            group("Group48")
            {
                Caption = 'Registers/Entries';

                action("FA Registers12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Registers';
                    RunObject = page "FA Registers";
                }
                action("Insurance Registers12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Registers';
                    RunObject = page "Insurance Registers";
                }
                action("FA Ledger Entries12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Ledger Entries';
                    RunObject = page "FA Ledger Entries";
                }
                action("Maintenance Ledger Entries12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance Ledger Entries';
                    RunObject = page "Maintenance Ledger Entries";
                }
                action("Ins. Coverage Ledger Entries12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Coverage Ledger Entries';
                    RunObject = page "Ins. Coverage Ledger Entries";
                }
            }
            group(Archive)
            {
                action("Archived Maintenance Request")
                {
                    RunObject = page "Maintenance Request List";
                    RunPageLink = Archive = const(true);
                }
                action("Approved Asset Maintenance Request List")
                {
                    RunObject = page "Asset Maintenance Request List";
                    RunPageLink = Archive = const(true);
                }
                action("Posted Asset Allocation")
                {
                    RunObject = page "Asset Allocation List";
                    RunPageLink = Allocated = filter(true);
                }
                action("Posted Asset Transfers")
                {
                    RunObject = page "Asset Transfer List";
                    RunPageLink = Transferred = filter(true);
                }
            }
            group("Group49")
            {
                Caption = 'Setup';

                action("FA Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Setup';
                    RunObject = page "Fixed Asset Setup";
                }
                action("FA Classes")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Classes';
                    RunObject = page "FA Classes";
                }
                action("FA Subclasses")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Subclasses';
                    RunObject = page "FA Subclasses";
                }
                action("FA Locations")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Locations';
                    RunObject = page "FA Locations";
                }
                action("FA Posting Groups")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Posting Groups';
                    RunObject = page "FA Posting Groups";
                }
                action("Asset Disposal Methods")
                {
                    RunObject = page "Asset Disposal Methods";
                }
                action("Insurance Types")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Types';
                    RunObject = page "Insurance Types";
                }
                action("Maintenance")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Maintenance';
                    RunObject = page "Maintenance";
                }
                action("Depreciation Books")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Depreciation Books';
                    RunObject = page "Depreciation Book List";
                }
                action("Depreciation Tables")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Depreciation Tables';
                    RunObject = page "Depreciation Table List";
                }
                action("FA Journal Templates")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Journal Templates';
                    RunObject = page "FA Journal Templates";
                }
                action("FA Reclass. Journal Templates")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'FA Reclassification Journal Template';
                    RunObject = page "FA Reclass. Journal Templates";
                }
                action("Insurance Journal Templates")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance Journal Templates';
                    RunObject = page "Insurance Journal Templates";
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
                action("Visitor's Interaction Books")
                {
                    RunObject = page "Enquiries General";
                }
            }
        }
        area(Reporting)
        {
            action("FA Disposal Requisition")
            {
                RunObject = report "FA Disposal Requisition";
            }
            action("Document Distribuion Form")
            {
                RunObject = report "Document Distribution";
            }
            action("Disposal Certificate")
            {
                RunObject = report "Disposal Certififcate";
            }
            action("Record Disposal Request Form")
            {
                RunObject = report "Record Disposal Request Form";
            }
            action("Registry File Update")
            {
                RunObject = report "Registry File UpDate";
            }
            action("Records Transfer Form")
            {
                RunObject = report "Records Transfer Form";
            }
            action("Fixed Asset Management Form")
            {
                RunObject = report "Fixed Asset Management Form";
            }
            action("Handing Over Taking Over")
            {
                RunObject = report "Handing Over Taking Over";
            }
        }
    }
}
