page 51294 "Performance Factor Lines"
{
    PageType = ListPart;
    Caption = 'Performance Targets';
    SourceTable = "Perfomance Factor Lines";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Enabled = false;
                }
                field("Agreed Performance Target"; Rec."Agreed Performance Target")
                {
                    ToolTip = 'Specifies the value of the Agreed Performance Target field.';
                    ApplicationArea = All;
                }
                field("Performance Rating"; Rec."Performance Rating")
                {
                }
                field("Revised Target"; Rec."Revised Target")
                {
                    ToolTip = 'Specifies the value of the Revised Target field.';
                    ApplicationArea = All;
                }
                field("Revised Indicator"; Rec."Revised Indicator")
                {
                    ToolTip = 'Specifies the value of the Revised Indicator field.';
                    ApplicationArea = All;
                }
                field(Factor; Rec.Factor)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Rating Of % level"; Rec."Rating Of % level")
                {
                    ToolTip = 'Specifies the value of the Rating Of % level field.';
                    ApplicationArea = All;
                }
                field("Performance Score"; Rec."Performance Score")
                {
                    ToolTip = 'Specifies the value of the Performance Score field.';
                    ApplicationArea = All;
                }
                field("Moderated Score"; Rec."Moderated Score")
                {
                    ToolTip = 'Specifies the value of the Moderated Score field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }
}
