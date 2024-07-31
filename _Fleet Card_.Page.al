page 50451 "Fleet Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Fixed Asset";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Car Info")
            {
                Caption = 'Car Info';

                label("Car Tracking Information")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Registration No"; Rec."Registration No")
                {
                }
                field("Card No"; Rec."Card No")
                {
                }
                field("Car Rating"; Rec."Car Rating")
                {
                }
                field("Year of Manufacture"; Rec.YOM)
                {
                }
                field("Vehicle Type"; Rec."Vehicle Type")
                {
                }
                field("Registration Type"; Rec."Registration Type")
                {
                }
                field(Duty; Rec.Duty)
                {
                }
                field(Disposed; Rec.Disposed)
                {
                }
                field("Car Tracking Company"; Rec."Car Tracking Company")
                {
                }
                field("Tracking Date"; Rec."Tracking Date")
                {
                }
                field("Tracking Renewal date"; Rec."Tracking Renewal Date")
                {
                }
                field("LogBook No"; Rec."Logbook No")
                {
                }
                field(Make; Rec.Make)
                {
                }
                field(Body; Rec.Body)
                {
                }
                field("Chassis No."; Rec."Chassis No.")
                {
                }
                field("Engine No."; Rec."Engine No.")
                {
                }
                field(Model; Rec.Model)
                {
                }
                field("Seating/carrying capacity"; Rec."Seating/carrying capacity")
                {
                }
                field("Current Odometer Reading"; Rec."Current Odometer Reading")
                {
                }
                field("Next Service Mileage"; Rec."Next Service Mileage")
                {
                }
                field("Inspection Due Date"; Rec."Inspection Due Date")
                {
                }
            }
            group("Insurance Info")
            {
                field("Policy No"; Rec."Policy No")
                {
                }
                field(Insurer; Rec.Insurer)
                {
                }
                field("Insurance Company"; Rec."Insurance Company")
                {
                }
                field("Premium Amount"; Rec."Premium Amount")
                {
                    Caption = 'Premium Paid';
                }
                field(Valuer; Rec.Valuer)
                {
                }
                field("Valuation Firm"; Rec."Valuation Firm")
                {
                }
                field("Last Valued Date"; Rec."Last Valued Date")
                {
                }
                field("Date of Commencement"; Rec."Date of Commencement")
                {
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                }
                field("Date of purchase"; Rec."Date of purchase")
                {
                }
                field("Hotline No"; Rec."Hotline No")
                {
                }
            }
            group(Maintenance)
            {
                Caption = 'Maintenance';

                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                }
                field("Maintainence Status"; Rec."Maintainence Status")
                {
                    Caption = 'Vehicle Status';
                }
            }
        }
        area(factboxes)
        {
            part(Control40; "Fixed Asset Picture")
            {
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Vehicle Accessories")
            {
                RunObject = Page "Vehicle Equipment";
                RunPageLink = "Vehicle No" = FIELD("No.");
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Fixed Asset Type" := Rec."Fixed Asset Type"::Fleet;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Fixed Asset Type" := Rec."Fixed Asset Type"::Fleet;
    end;
}
