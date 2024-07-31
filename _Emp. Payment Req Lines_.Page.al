page 50660 "Emp. Payment Req Lines"
{
    PageType = ListPart;
    SourceTable = "Employee Pay Requests";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Employee Category"; Rec.Type)
                {
                }
                field("Payment Type"; Rec."Payment Type")
                {
                }
                field("Start Time"; Rec."Start Time")
                {
                }
                field("End Time"; Rec."End Time")
                {
                }
                field("No. of Units"; Rec."No. of Units")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field(Leason; Rec.Leason)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("ED Code"; Rec."ED Code")
                {
                }
                field(Rate; Rec.Rate)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Document No"; Rec."Document No")
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
            }
            action("Cancel Approval Request")
            {
            }
        }
    }
    trigger OnOpenPage()
    begin
        //SETRANGE("USER ID",USERID);
    end;
}
