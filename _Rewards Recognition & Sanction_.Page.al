page 51472 "Rewards Recognition & Sanction"
{
    Caption = 'Rewards Recognition & Sanction';
    PageType = ListPart;
    SourceTable = "Rewards Recognition & Sanction";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Reward Type"; Rec."Reward Type")
                {
                    ApplicationArea = All;
                    Enabled = Rec.Category = Rec.Category::Rewards;
                    ToolTip = 'Specifies the value of the Reward Type field.';
                }
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }
}
