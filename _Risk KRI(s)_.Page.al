page 51195 "Risk KRI(s)"
{
    PageType = ListPart;
    SourceTable = "Risk Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(KRI; Rec.KRI)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Tolerance; Rec.Tolerance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Appetite; Rec.Appetite)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Quantification; Rec.Quantification)
                {
                    ApplicationArea = All;
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Update Frequency"; Rec."Update Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Auditor's Response"; Rec."Auditor's Response")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
