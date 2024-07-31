page 51435 "Appraisee Additional Assign. 2"
{
    Caption = 'Appraisee Additional Assign. 2';
    PageType = ListPart;
    SourceTable = "Appraisee Additional Assign.";
    SourceTableView = where(Adhoc = const(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Agreed Performance Target"; Rec."Agreed Performance Target")
                {
                    ToolTip = 'Specifies the value of the Agreed Performance Target field.';
                    ApplicationArea = All;
                }
                field("Performance Indicator"; Rec."Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator field.';
                    ApplicationArea = All;
                }
                field("Achieved Results"; Rec."Achieved Results")
                {
                    ToolTip = 'Specifies the value of the Achieved Results field.';
                    ApplicationArea = All;
                }
                field("Ratings Of % Level"; Rec."Ratings Of % Level")
                {
                    ToolTip = 'Specifies the value of the Ratings Of % Level field.';
                    ApplicationArea = All;
                }
                field("Performance Appraisal Score"; Rec."Performance Appraisal Score")
                {
                    ToolTip = 'Specifies the value of the Performance Appraisal Score field.';
                    ApplicationArea = All;
                }
                field("Moderated Score"; Rec."Moderated Score")
                {
                    ToolTip = 'Specifies the value of the Moderated Score field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        Rec.Adhoc := true;
    end;
}
