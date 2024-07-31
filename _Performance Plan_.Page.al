page 50413 "Performance Plan"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    SourceTableView = WHERE("Appraisal Heading Type" = CONST(Objectives));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    Visible = false;
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Objectives';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Action Plan';
                }
                field(Rating; Rec.Rating)
                {
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Caption = 'Reasons';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Lock Targets")
            {
                Image = CompleteLine;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Review;
                    Setting := true;
                    Message('Target Locked');
                end;
            }
            action("Review Target")
            {
                Image = DocumentEdit;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Appraisal;
                    Setting := false;
                    Review := true;
                    Message('Targets Changed');
                end;
            }
            action("Score Awards")
            {
                Image = Confirm;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Setting;
                    Message('Score Awarded');
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Appraisal Heading Type" := Rec."Appraisal Heading Type"::Objectives;
    end;

    var
        Setting: Boolean;
        Review: Boolean;
        Ranking: Boolean;

    procedure SetStatus()
    begin
    end;
}
