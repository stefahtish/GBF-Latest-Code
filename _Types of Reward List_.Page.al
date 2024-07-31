page 51469 "Types of Reward List"
{
    ApplicationArea = All;
    Caption = 'Types of Reward List';
    PageType = List;
    SourceTable = "Recognitions and Rewards Setup";
    UsageCategory = Administration;
    SourceTableView = where(Category=const(Rewards));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Category:=Rec.Category::Rewards;
    end;
}
