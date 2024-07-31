page 51282 "Vendor Evaluation Setup Card"
{
    PageType = Card;
    SourceTable = "Supplier Evaluation SetUp";
    ApplicationArea = All;

    //SourceTableView = where(Type = const(Existing));
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
                field("Evaluation Description"; Rec."Evalueation Description")
                {
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
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
                field("Score Criteria"; Rec."Score Criteria")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Maximum Score"; Rec."Total Maximum Score")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Supplier Eval Setup Lines")
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
