page 50672 "Earnings Imported"
{
    PageType = List;
    SourceTable = "Earning 1";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Emp No."; Rec."Emp No.")
                {
                }
                field(E001; Rec.E001)
                {
                }
                field(E002; Rec.E002)
                {
                }
                field(E003; Rec.E003)
                {
                }
                field(E004; Rec.E004)
                {
                }
                field(E005; Rec.E005)
                {
                }
                field(E006; Rec.E006)
                {
                }
                field(E007; Rec.E007)
                {
                }
                field(E008; Rec.E008)
                {
                }
                field(E009; Rec.E009)
                {
                }
                field(E010; Rec.E010)
                {
                }
                field(E011; Rec.E011)
                {
                }
                field(E012; Rec.E012)
                {
                }
                field(E013; Rec.E013)
                {
                }
                field(E014; Rec.E014)
                {
                }
                field(E015; Rec.E015)
                {
                }
                field(E016; Rec.E016)
                {
                }
                field(E017; Rec.E017)
                {
                }
                field(E018; Rec.E018)
                {
                }
                field(E019; Rec.E019)
                {
                }
                field(E020; Rec.E020)
                {
                }
                field(E021; Rec.E021)
                {
                }
                field(E022; Rec.E022)
                {
                }
                field(E023; Rec.E023)
                {
                }
                field(E024; Rec.E024)
                {
                }
                field(E025; Rec.E025)
                {
                }
                field(E026; Rec.E026)
                {
                }
                field(E027; Rec.E027)
                {
                }
                field(E028; Rec.E028)
                {
                }
                field(E029; Rec.E029)
                {
                }
                field(E030; Rec.E030)
                {
                }
                field(E031; Rec.E031)
                {
                }
                field(E032; Rec.E032)
                {
                }
                field(E033; Rec.E033)
                {
                }
                field(E034; Rec.E034)
                {
                }
                field(E035; Rec.E035)
                {
                }
                field(E036; Rec.E036)
                {
                }
                field(E037; Rec.E037)
                {
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Import Earnings")
            {
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*CLEAR(EarnImport);
                    EarnImport.RUN;
                    */
                    Clear(JanImpo);
                    JanImpo.Run;
                end;
            }
        }
    }
    var
        JanImpo: XMLport "Jan Earn Import";
}
