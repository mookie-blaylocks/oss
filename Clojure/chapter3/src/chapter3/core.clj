(ns chapter3.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

(defn error-message
  [severity]
  (str "OH GOD! IT'S A DISASTER WE'RE "
  (if (= severity :mild)
   "MILDLY INCONVENIENCED!"
   "DOOOMED!")))

(def name {:first-name "Charlie"
           :last-name "Hebdo"})
