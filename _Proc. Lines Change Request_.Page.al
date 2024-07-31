page 50876 "Proc. Lines Change Request"
{
    PageType = ListPart;
    SourceTable = "Proc. Lines Change Request";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Specification2; SpecificationTxt)
                {
                    Caption = 'Specifications';
                    //MultiLine = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Specification2);
                        rec.Specification2.CreateInStream(InStrm);
                        SpecificationBigTxt.read(InStrm);
                        if SpecificationTxt <> format(SpecificationBigTxt) then begin
                            Clear(Rec.Specification2);
                            Clear(SpecificationBigTxt);
                            SpecificationBigTxt.AddText(SpecificationTxt);
                            rec.Specification2.CreateOutStream(OutStrm);
                            SpecificationBigTxt.Write(OutStrm)
                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Procurement Plan Item"; Rec."Procurement Plan Item")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    var
    begin
        Rec.CalcFields(Specification2);
        rec.Specification2.CreateInStream(InStrm);
        SpecificationBigTxt.Read(InStrm);
        SpecificationTxt := Format(SpecificationBigTxt);
    end;

    var
        InStrm: InStream;
        OutStrm: OutStream;
        SpecificationBigTxt: BigText;
        SpecificationTxt: Text;
}
