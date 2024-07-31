page 50566 "Employee Insurance List"
{
    Caption = 'Employee Insurance List';
    PageType = ListPart;
    SourceTable = "Employee Insurance";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Insurance Company"; Rec."Insurance Company")
                {
                    ApplicationArea = All;
                }
                field("Policy No"; Rec."Policy No")
                {
                    ApplicationArea = All;
                }
                field("Deduction code"; Rec."Deduction code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
