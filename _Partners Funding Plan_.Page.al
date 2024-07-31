page 51103 "Partners Funding Plan"
{
    PageType = ListPart;
    SourceTable = "Partnerships Activity Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Name';
                    ApplicationArea = Basic, Suite;
                }
                field("Budgetary Plan"; Rec."Budgetary Plan")
                {
                    Caption = 'Budgetary Input';
                }
            }
        }
    }
    actions
    {
    }
}
