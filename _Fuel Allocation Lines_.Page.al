page 51275 "Fuel Allocation Lines"
{
    Caption = 'Fuel Allocation Lines';
    PageType = ListPart;
    SourceTable = "Fuel Allocation Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vehicle "; Rec."Vehicle")
                {
                    ApplicationArea = All;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = All;
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ApplicationArea = All;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Previous Balance"; Rec."Previous Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Topup Amount"; Rec."Topup Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        HRManagement.GetFuelBalance(Rec);
        Rec.CalcFields(Usage);
    end;

    var
        HRManagement: Codeunit "HR Management";
}
