page 50835 "Tariff Codes"
{
    PageType = List;
    SourceTable = "Tariff Codes";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
    }
}
