page 50817 "Supplier Evaluation SubForm"
{
    PageType = ListPart;
    SourceTable = "Supplier Evaluation Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No"; Rec."Quote No")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Supplier; Rec.Supplier)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = all;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec.Score > Rec."Max Score" then Error('Score Cannot Exceed Maximum Score');
                    end;
                }
                field("Max Score"; Rec."Max Score")
                {
                    Visible = false;
                    Enabled = false;
                    ApplicationArea = all;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = all;
                }
                field(Pass; Rec.Pass)
                {
                    ApplicationArea = all;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Insert Scores")
            {
                Image = Calculate;
                ApplicationArea = all;
                RunObject = page "Supplier Evaluation Scores";
                RunPageLink = "Document No." = field("Quote No"), "Supplier Code" = field(Supplier);
                RunPageMode = Edit;

                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
}
