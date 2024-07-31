page 51386 "Supplier EvaluationSetupCard1"
{
    Caption = 'Supplier Evaluation Setup Card';
    PageType = Card;
    SourceTable = "Supplier Evaluation SetUp";
    ApplicationArea = All;

    //SourceTableView = where(Type = const(Quotation));
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Evalueation Description"; Rec."Evalueation Description")
                {
                    Caption = 'Evaluation Description';
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
                field("Score Criteria"; Rec."Score Criteria")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //CurrPage.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                }
                field("Procurement Ref No."; Rec."Procurement Ref No.")
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
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                    ApplicationArea = All;
                }
                field("Total PassMark"; Rec."Total PassMark")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Evaluation Stage"; Rec."Evaluation Stage")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
            part(Lines; "Supplier Eval Setup Lines1")
            {
                SubPageLink = Code = field(Code);
                UpdatePropagation = Both;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Type := Rec.Type::Tender;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Tender;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields(Description);
        rec.Description.CreateInStream(InStrm);
        DesciptionBigTxt.Read(InStrm);
        DescriptionTxt := Format(DesciptionBigTxt);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        DesciptionBigTxt: BigText;
        DescriptionTxt: Text;
}
