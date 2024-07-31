page 51434 "Apprasisee Additional Assign."
{
    Caption = 'Apprasisee Additional Assign.';
    PageType = ListPart;
    SourceTable = "Appraisee Additional Assign.";
    SourceTableView = where(Adhoc = const(false));
    AutoSplitKey = true;
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
                field(Assignment; Rec.Assignment)
                {
                    ToolTip = 'Specifies the value of the Assignment field.';
                    ApplicationArea = All;
                }
                field("Date Assigned"; Rec."Date Assigned")
                {
                    ToolTip = 'Specifies the value of the Date Assigned field.';
                    ApplicationArea = All;
                }
                field("Assigned By"; Rec."Assigned By")
                {
                    ToolTip = 'Specifies the value of the Assigned By field.';
                    ApplicationArea = All;
                }
                field("Implementation Status"; Rec."Implementation Status")
                {
                    ToolTip = 'Specifies the value of the Implementation Status field.';
                    ApplicationArea = All;
                }
                field("Date Of Completion"; Rec."Date Of Completion")
                {
                    ToolTip = 'Specifies the value of the Date Of Completion field.';
                    ApplicationArea = All;
                }
                field(Evidence; Rec.Evidence)
                {
                    ToolTip = 'Specifies the value of the Evidence field.';
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
        Rec.Adhoc := false;
    end;
}
