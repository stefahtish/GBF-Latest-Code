page 51288 "Vendor Evaluation SubForm"
{
    PageType = ListPart;
    SourceTable = "Vendor Evaluation Line";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field(Supplier; Rec.Supplier)
                {
                    Editable = false;
                }
                field("Evaluation Type"; Rec."Evaluation Type")
                {
                }
                field("Evaluation Line"; Rec."Evaluation Line")
                {
                }
                field("Line Description"; DescTxt)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields("Line Description");
                        rec."Line Description".CreateInStream(Instrm);
                        DescBigTxt.Read(Instrm);
                        if DescTxt <> format(DescBigTxt) then begin
                            Clear(Rec."Line Description");
                            Clear(DescBigTxt);
                            DescBigTxt.AddText(DescTxt);
                            rec."Line Description".CreateOutStream(OutStrm);
                            DescBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field(Score; Rec.Score)
                {
                    trigger OnValidate()
                    begin
                        if Rec.Score > Rec."Max Score" then Error('Score Cannot Exceed Maximum Score');
                    end;
                }
                field("Max Score"; Rec."Max Score")
                {
                    Visible = false;
                    Enabled = false;
                }
                field("Total Score"; Rec."Total Score")
                {
                }
                field(Pass; Rec.Pass)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            // action("Insert Scores")
            // {
            //     Image = Calculate;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Process;
            //     RunObject = page "Supplier Evaluation Scores";
            //     RunPageLink = "Document No." = field("Quote No"), "Supplier Code" = field(Supplier);
            //     RunPageMode = Edit;
            //     trigger OnAction()
            //     begin
            //         CurrPage.Update();
            //     end;
            // }
        }
    }
    trigger OnOpenPage()
    begin
        GetHeader();
    end;

    trigger OnAfterGetRecord()
    begin
        GetHeader();
    end;

    var
        Instrm: InStream;
        Outstrm: OutStream;
        DescBigTxt: BigText;
        DescTxt: Text;

    local procedure GetHeader()
    begin
        Rec.CalcFields("Line Description");
        rec."Line Description".CreateInStream(Instrm);
        DescBigTxt.Read(Instrm);
        DescTxt := Format(DescBigTxt);
    end;
}
