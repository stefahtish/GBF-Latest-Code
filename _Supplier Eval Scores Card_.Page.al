page 50832 "Supplier Eval Scores Card"
{
    Caption = 'Supplier Evaluation Scores Card';
    PageType = Card;
    SourceTable = "Supplier Evaluation Score";
    DeleteAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("Score Parameter"; Rec."Score Parameter")
                {
                    ApplicationArea = All;
                }
                field("Score Description"; Rec."Score Description")
                {
                    ApplicationArea = All;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                }
                field(Description; DescriptionTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Description);
                        rec.Description.CreateInStream(InStrm);
                        DesciptionBigTxt.read(InStrm);
                        if DescriptionTxt <> format(DesciptionBigTxt) then begin
                            Clear(Rec.Description);
                            Clear(DesciptionBigTxt);
                            DesciptionBigTxt.AddText(DescriptionTxt);
                            rec.Description.CreateOutStream(OutStrm);
                            DesciptionBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field("Total Score"; Rec."Total Score")
                {
                    ApplicationArea = All;
                    Visible = ScoresVisible;
                }
                field("Total Passmark"; Rec."Total Passmark")
                {
                    Enabled = false;
                    Visible = ScoresVisible;
                }
                field(Submitted; Rec.Submitted)
                {
                    ApplicationArea = all;
                }
            }
            part(Lines; "Supplier Eval Score Lines")
            {
                Editable = Rec.Submitted = false;
                SubPageLink = "Document No." = field("Document No."), "Supplier Code" = field("Supplier Code"), "Score Parameter" = field("Score Parameter");
                UpdatePropagation = Both;
            }
        }
    }
    trigger OnOpenPage()
    begin
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Description);
        rec.Description.CreateInStream(InStrm);
        DesciptionBigTxt.Read(InStrm);
        DescriptionTxt := Format(DesciptionBigTxt);
        SetControlAppearance();
    end;

    var
        SupplierEval: Record "Supplier Evaluation Header";
        InStrm: InStream;
        OutStrm: OutStream;
        DesciptionBigTxt: BigText;
        DescriptionTxt: Text;
        ScoresVisible: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec."Score Criteria" = Rec."Score Criteria"::Score then
            ScoresVisible := true
        else
            ScoresVisible := false;
    end;
}
