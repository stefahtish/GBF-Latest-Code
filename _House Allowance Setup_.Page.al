page 50714 "House Allowance Setup"
{
    Caption = 'House Allowance Setup';
    PageType = List;
    SourceTable = "House Allowances";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Job group"; Rec."Job group")
                {
                    ApplicationArea = All;
                }
                field(Pointer; Rec.Pointer)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        Earnings: Record EarningsX;
    begin
        Earnings.reset;
        Earnings.SetRange("House Allowance Code", true);
        if Earnings.FindFirst() then Rec.Code := Earnings.Code;
    end;
}
