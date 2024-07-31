page 51471 "Types of Sanction List"
{
    ApplicationArea = All;
    Caption = 'Types of Sanction List';
    PageType = List;
    SourceTable = "Recognitions and Rewards Setup";
    UsageCategory = Administration;
    SourceTableView = where(Category=const(Sanctions));

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
        Rec.Category:=Rec.Category::Sanctions;
    end;
}
